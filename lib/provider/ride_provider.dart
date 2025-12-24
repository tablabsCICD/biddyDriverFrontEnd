import 'dart:async';
import 'dart:convert';

import 'package:biddy_driver/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant/api_constant.dart';
import '../constant/app_constant.dart';
import '../model/activeRideResponse.dart';
import '../model/api_response.dart';
import '../model/base_model/driver_model.dart';
import '../model/base_model/ride_model.dart';
import '../model/ride_status_change_response.dart';
import '../route/app_routes.dart';
import '../util/sharepreferences.dart';

class RideProvider extends BaseProvider {
  RideProvider(BuildContext context) : super("");

  /// =========================
  /// RIDE LISTS
  /// =========================
  final List<RideData> activeRideList = [];
  final List<RideData> completedRideList = [];
  final List<RideData> cancelledRideList = [];

  /// =========================
  /// LOADING
  /// =========================
  bool isLoading = false;
  bool isLoad = false;

  /// =========================
  /// PAGINATION
  /// =========================
  int _page = 0;
  bool _hasMore = true;

  /// =========================
  /// HELPERS
  /// =========================
  bool _contains(List<RideData> list, int? id) {
    return list.any((e) => e.id == id);
  }

  /// =========================
  /// FETCH RIDES
  /// =========================
  Future<List<RideData>> _fetchRides(BuildContext context) async {
    try {
      DriverModel user = await LocalSharePreferences().getLoginData();
      int? driverId = user.data?.id;

      if (driverId == null) return [];

      final url =
          "${APIConstants.ALL_RIDE_DRIVERID}$driverId?page=$_page";

      /// Ensure HTTPS
      final uri = Uri.parse(url);

      debugPrint("Fetching rides: $uri");

      final response = await http.get(
        uri,
        headers: const {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final ActiveRideListResponse res =
        ActiveRideListResponse.fromJson(
          jsonDecode(response.body),
        );
        completedRideList.addAll(res.data as Iterable<RideData>);
        debugPrint("Response: ${res.data}");

        debugPrint("Response: ${res.data!.length}");

        return res.data ?? [];
      } else {
        debugPrint("Failed with status: ${response.statusCode}");
        return [];
      }
    } catch (e, stackTrace) {
      debugPrint("Fetch rides error: $e");
      debugPrintStack(stackTrace: stackTrace);
      return [];
    }
  }

  /// =========================
  /// LOAD RIDES (ALL TABS)
  /// =========================
  Future<void> loadRides(
      BuildContext context, {
        bool refresh = false,
      }) async {
    if (isLoading || (!_hasMore && !refresh)) return;

    isLoading = true;
    notifyListeners();

    if (refresh) {
      _page = 0;
      _hasMore = true;
      activeRideList.clear();
      completedRideList.clear();
      cancelledRideList.clear();
    }

    List<RideData> data = await _fetchRides(context);

    for (final ride in data) {
      debugPrint("Status: ${ride.status}");

      if (ride.status == AppConstant.status_end_ride) {
        if (!_contains(completedRideList, ride.id)) {
          completedRideList.add(ride);
        }
      }

    /// CANCELLED
      else if (ride.status == AppConstant.status_cancelled) {
        if (!_contains(cancelledRideList, ride.id)) {
          cancelledRideList.add(ride);
        }
      }
      /// ACTIVE
      else {
        if (!_contains(activeRideList, ride.id)) {
          activeRideList.add(ride);
        }
      }
    }
    debugPrint("Response: ${completedRideList.length}");


    _hasMore = data.isNotEmpty;
    _page++;

    isLoading = false;
    notifyListeners();
  }

  /// ===============================
  /// CHANGE RIDE STATUS
  /// ===============================
  Future<void> changeStatus(
      BuildContext context,
      String status,
      RideData rideData,
      ) async {
    isLoad = true;
    notifyListeners();

    try {
      String url = APIConstants.RIDE_STATUS_CHANGE;

      ApiResponse apiResponse =
      await AppConstant.apiHelper.putDataArgument(
        url,
        {
          "id": rideData.id,
          "status": status,
        },
      );

      if (apiResponse.status == 200) {
        final res = jsonDecode(apiResponse.response);
        RideStatusChangeResponse response =
        RideStatusChangeResponse.fromJson(res);

        RideData updatedRide = response.data!;

        /// REMOVE FROM ALL LISTS
        activeRideList.removeWhere((e) => e.id == updatedRide.id);
        completedRideList.removeWhere((e) => e.id == updatedRide.id);
        cancelledRideList.removeWhere((e) => e.id == updatedRide.id);

        /// ADD TO CORRECT LIST
        if (updatedRide.status == AppConstant.status_end_ride) {
          completedRideList.insert(0, updatedRide);
        } else if (updatedRide.status == AppConstant.status_cancelled) {
          cancelledRideList.insert(0, updatedRide);
        } else {
          activeRideList.insert(0, updatedRide);
        }

        notifyListeners();

        /// NAVIGATION
        if (status == AppConstant.status_end_ride) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.endride,
            arguments: updatedRide,
          );
        }
      }
    } catch (e) {
      debugPrint("Change status failed: $e");
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }
}
