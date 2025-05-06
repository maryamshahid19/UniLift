import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/models/ride.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/repositories/auth_repository.dart';
import 'package:unilift/repositories/rides_repository.dart';
import 'package:unilift/screens/login_screen.dart';
import 'package:unilift/widgets/listTiles/customRideHistoryTile.dart';
import 'package:unilift/widgets/listTiles/customRideTile.dart';
import 'package:unilift/widgets/text/customText.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.user});

  final UserModel user;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> _refreshRides() async {
    setState(() {
      RidesRepository().fetchAllRides();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrUtils.secondary,
      body: SafeArea(
        child: Container(
          height: SizeCons.getHeight(context),
          width: SizeCons.getWidth(context),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ClrUtils.primary,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 180, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Available Rides",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _refreshRides,
                          child: FutureBuilder<List<RideModel>>(
                              future: RidesRepository().fetchAllRides(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Error: ${snapshot.error}"));
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No carpool rides found.'));
                                }

                                List<RideModel> rides = snapshot.data!;
                                rides = rides
                                    .where((ride) =>
                                        ride.from == widget.user.university ||
                                        ride.to == widget.user.university)
                                    .toList();

                                if (rides.isEmpty) {
                                  return const Center(
                                      child: Text('No carpool rides found.'));
                                }

                                return ListView.builder(
                                  itemCount: rides.length,
                                  itemBuilder: (context, index) {
                                    final ride = rides[index];

                                    return CustomRideListTile(
                                      ride: ride,
                                      user: widget.user,
                                      onPressed: () {},
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: SizeCons.getWidth(context),
                height: SizeCons.getHeight(context) * 0.15,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: ClrUtils.secondary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Hello,",
                              color: ClrUtils.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              text: widget.user.fullName,
                              color: ClrUtils.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            AuthRepository().logOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen()));
                          },
                          icon: Icon(Icons.logout),
                          color: ClrUtils.primary,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
