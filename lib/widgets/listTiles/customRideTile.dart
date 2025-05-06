import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/models/ride.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/popup/ride_details_popup.dart';
import 'package:unilift/widgets/text/customText.dart';

class CustomRideListTile extends StatelessWidget {
  final RideModel ride;
  final UserModel user;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double fontSize;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final Color borderColor;
  final double borderWidth;

  const CustomRideListTile({
    super.key,
    required this.ride,
    required this.user,
    required this.onPressed,
    this.color = ClrUtils.secondary,
    this.textColor = ClrUtils.textPrimary,
    this.borderRadius = 10.0,
    this.elevation = 0,
    this.fontSize = 14.0,
    this.height = 48,
    this.width = double.infinity,
    this.fontWeight = FontWeight.normal,
    this.borderColor = ClrUtils.border,
    this.borderWidth = 1,
  });

  void showRideDetailsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RideDetailPopup(
          ride: ride,
          user: user,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ClrUtils.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: ride.owner,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black,
                ),
                CustomText(
                  text: "${ride.availableSeats} seat left",
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 5),
            CustomText(
              text: DateFormat('dd MMMM h:mm a').format(ride.dateTime),
              fontSize: 14,
              color: Colors.grey[600]!,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: ride.from,
                          fontSize: 14,
                          color: Colors.grey[600]!,
                        ),
                        CustomText(
                          text: " -> ",
                          fontSize: 14,
                          color: Colors.grey[600]!,
                        ),
                        CustomText(
                          text: ride.to,
                          fontSize: 14,
                          color: Colors.grey[600]!,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/uber.png',
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          text: ride.carType,
                          fontSize: 14,
                          color: Colors.grey[700]!,
                        ),
                      ],
                    ),
                  ],
                ),
                ride.availableSeats == 0
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(49, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "All Booked",
                                style: TextStyle(color: ClrUtils.tertiary),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          onPressed: () {
                            showRideDetailsPopup(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "Book",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 16),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
