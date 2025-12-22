import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/constant/imageconstant.dart';
import 'package:biddy_driver/provider/book_ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../model/ride_status_change_response.dart';
import '../../route/app_routes.dart';

class BiddyWaitScreen extends StatefulWidget {
  final int rideId;
  final int driverId;

  const BiddyWaitScreen({
    super.key,
    required this.rideId,
    required this.driverId,
  });

  @override
  State<BiddyWaitScreen> createState() => _BiddyWaitState();
}

class _BiddyWaitState extends State<BiddyWaitScreen> {
  Timer? _timer;
  int _retryCount = 0;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookRideProvider("Ideal"),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FadeAnimatedText(
                      'Waiting for customer response...',
                      duration: const Duration(seconds: 5),
                    ),
                    FadeAnimatedText(
                      'This will take less than a minute',
                      duration: const Duration(seconds: 5),
                    ),
                    FadeAnimatedText(
                      'Please wait...',
                      duration: const Duration(seconds: 5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  // ================= TIMER =================

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkRideStatus();
    });
  }

  // ================= API =================

  Future<void> _checkRideStatus() async {
    if (_navigated) return;

    final String url =
        "${APIConstants.GET_RIDE_BY_ID}${widget.rideId}";
    debugPrint("Checking ride status: $url");

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        _goHome();
        return;
      }

      final RideStatusChangeResponse ride =
      RideStatusChangeResponse.fromJson(
          jsonDecode(response.body));

      final status =
          ride.data?.status?.toLowerCase() ?? "";

      if (status == AppConstant.status_pending) {
        _retryCount++;
        if (_retryCount >= 10) {
          _timer?.cancel();
          _goHome();
        }
        return;
      }

      if (status == AppConstant.status_accepted) {
        _timer?.cancel();

        if (!mounted) return;

        _navigated = true;

        if (ride.data?.driverId?.id == widget.driverId) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.bookedride,
            arguments: {
              "rideId": widget.rideId,
            },
          );
        } else {
          _goHome();
        }
      }
    } catch (e) {
      debugPrint("Ride status API failed: $e");
    }
  }

  // ================= NAVIGATION =================

  void _goHome() {
    if (!mounted || _navigated) return;

    _navigated = true;
    _timer?.cancel();

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.home,
    );
  }
}
