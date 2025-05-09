// import 'package:flutter/material.dart';
// import 'package:unilift/constants/color_constants.dart';
// import 'package:unilift/constants/screensize_constants.dart';
// import 'package:unilift/models/ride.dart';
// import 'package:unilift/models/user.dart';
// import 'package:unilift/repositories/rides_repository.dart';
// import 'package:unilift/widgets/listTiles/customRideTile.dart';

// class CarpoolHistoryScreen extends StatefulWidget {
//   const CarpoolHistoryScreen({super.key, required this.user});

//   final UserModel user;

//   @override
//   State<CarpoolHistoryScreen> createState() => _CarpoolHistoryScreenState();
// }

// class _CarpoolHistoryScreenState extends State<CarpoolHistoryScreen> {
//   Future<void> _refreshBookedRides() async {
//     setState(() {
//       RidesRepository().fetchBookedRides(widget.user.userId);
//     });
//   }

//   Future<void> _refreshCreatedRides() async {
//     setState(() {
//       RidesRepository().fetchCreatedRides(widget.user.userId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Carpool History")),
//       backgroundColor: ClrUtils.secondary,
//       body: SafeArea(
//         child: Container(
//           height: SizeCons.getHeight(context),
//           width: SizeCons.getWidth(context),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: ClrUtils.primary,
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                   padding: const EdgeInsets.fromLTRB(20, 180, 20, 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Booked Carpool Rides",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       Expanded(
//                         child: RefreshIndicator(
//                           onRefresh: _refreshBookedRides,
//                           child: FutureBuilder<List<RideModel>>(
//                               future: RidesRepository().fetchAllRides(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return const Center(
//                                       child: CircularProgressIndicator());
//                                 }

//                                 if (snapshot.hasError) {
//                                   return Center(
//                                       child: Text("Error: ${snapshot.error}"));
//                                 }

//                                 if (!snapshot.hasData ||
//                                     snapshot.data!.isEmpty) {
//                                   return const Center(
//                                       child: Text('No carpool rides found.'));
//                                 }

//                                 List<RideModel> rides = snapshot.data!;
//                                 rides = rides
//                                     .where((ride) =>
//                                         ride.from == widget.user.university ||
//                                         ride.to == widget.user.university)
//                                     .toList();

//                                 if (rides.isEmpty) {
//                                   return const Center(
//                                       child: Text('No carpool rides found.'));
//                                 }

//                                 return Expanded(
//                                   child: ListView.builder(
//                                     itemCount: rides.length,
//                                     itemBuilder: (context, index) {
//                                       final ride = rides[index];

//                                       return CustomRideListTile(
//                                         ride: ride,
//                                         user: widget.user,
//                                         onPressed: () {},
//                                       );
//                                     },
//                                   ),
//                                 );
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/models/ride.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/repositories/rides_repository.dart';
import 'package:unilift/widgets/listTiles/customRideHistoryTile.dart';
import 'package:unilift/widgets/listTiles/customRideTile.dart';
import 'package:unilift/widgets/text/customText.dart';

class CarpoolHistoryScreen extends StatefulWidget {
  const CarpoolHistoryScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<CarpoolHistoryScreen> createState() => _CarpoolHistoryScreenState();
}

class _CarpoolHistoryScreenState extends State<CarpoolHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<void> _refreshBookedRides() async {
    setState(() {});
  }

  Future<void> _refreshCreatedRides() async {
    setState(() {});
  }

  Widget buildRideList(bool isBookedTab) {
    final future = isBookedTab
        ? RidesRepository().fetchBookedRides(widget.user.fullName)
        : RidesRepository().fetchCreatedRides(widget.user.fullName);

    final refresh = isBookedTab ? _refreshBookedRides : _refreshCreatedRides;

    return RefreshIndicator(
      onRefresh: refresh,
      child: FutureBuilder<List<RideModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No carpool rides found.'));
          }

          final rides = snapshot.data!;
          return ListView.builder(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              if (isBookedTab) {
                return CustomBookedRideHistoryTile(
                  ride: ride,
                  user: widget.user,
                  isBookedTab: true,
                  onPressed: () {},
                );
              }
              return CustomBookedRideHistoryTile(
                ride: ride,
                user: widget.user,
                isBookedTab: false,
                onPressed: () {},
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const CustomText(
            text: "Carpool History",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          backgroundColor: ClrUtils.background,
          bottom: TabBar(
            controller: _tabController,
            labelColor: ClrUtils.secondary,
            indicatorColor: ClrUtils.secondary,
            unselectedLabelColor: ClrUtils.textSecondary,
            tabs: const [
              Tab(text: "Booked Rides"),
              Tab(text: "Created Rides"),
            ],
          ),
        ),
        backgroundColor: ClrUtils.secondary,
        body: SafeArea(
          child: Container(
            height: SizeCons.getHeight(context),
            width: SizeCons.getWidth(context),
            decoration: const BoxDecoration(
              color: ClrUtils.primary,
            ),
            padding: const EdgeInsets.all(16),
            child: TabBarView(
              controller: _tabController,
              children: [
                buildRideList(true), // Booked Rides
                buildRideList(false), // Created Rides
              ],
            ),
          ),
        ),
      ),
    );
  }
}
