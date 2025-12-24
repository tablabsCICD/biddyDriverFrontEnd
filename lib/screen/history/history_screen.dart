import 'package:biddy_driver/provider/ride_provider.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/base_model/ride_model.dart';
import 'active_rides.dart';
import 'completed_rides.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RideProvider(context),
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatefulWidget {
  const _HistoryView();

  @override
  State<_HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<_HistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    /// 🔹 Initial load (only once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RideProvider>().loadRides(context, refresh: true);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: TextView(
          title: "History",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: "Active Now"),
            Tab(text: "Completed"),
            Tab(text: "Cancelled"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ActiveTab(),
          _CompletedTab(),
          _CancelledTab(),
        ],
      ),
    );
  }
}

class _ActiveTab extends StatelessWidget {
  const _ActiveTab();

  @override
  Widget build(BuildContext context) {
    return Selector<RideProvider, List<RideData>>(
      selector: (_, p) => p.activeRideList,
      builder: (_, list, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<RideProvider>().loadRides(
              context,
              refresh: true,
            );
          },
          child: list.isEmpty
              ? const _EmptyState(message: "No active rides")
              : ActiveRides(rideList: list),
        );
      },
    );
  }
}

class _CompletedTab extends StatelessWidget {
  const _CompletedTab();

  @override
  Widget build(BuildContext context) {
    return Selector<RideProvider, List<RideData>>(
      selector: (_, p) => p.completedRideList,
      builder: (_, list, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<RideProvider>().loadRides(
              context,
              refresh: true,
            );
          },
          child: list.isEmpty
              ? const _EmptyState(message: "No completed rides")
              : CompletedScreen(rideList: list),
        );
      },
    );
  }
}

class _CancelledTab extends StatelessWidget {
  const _CancelledTab();

  @override
  Widget build(BuildContext context) {
    return Selector<RideProvider, List<RideData>>(
      selector: (_, p) => p.cancelledRideList,
      builder: (_, list, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<RideProvider>().loadRides(
              context,
              refresh: true,
            );
          },
          child: list.isEmpty
              ? const _EmptyState(message: "No cancelled rides")
              : CompletedScreen(rideList: list),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;

  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        Center(
          child: Column(
            children: const [
              Icon(Icons.history, size: 48, color: Colors.grey),
              SizedBox(height: 12),
            ],
          ),
        ),
        Center(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
