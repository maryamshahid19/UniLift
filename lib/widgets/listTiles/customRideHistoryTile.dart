import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/models/ride.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/popup/ride_details_popup.dart';
import 'package:unilift/widgets/text/customText.dart';

class CustomBookedRideHistoryTile extends StatelessWidget {
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
  final bool isBookedTab;

  const CustomBookedRideHistoryTile({
    super.key,
    required this.ride,
    required this.user,
    required this.isBookedTab,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: ride.from,
                  fontSize: 18,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w900,
                  color: ClrUtils.tertiary,
                ),
                CustomText(
                  text: " -> ",
                  fontSize: 18,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w900,
                  color: ClrUtils.tertiary,
                ),
                CustomText(
                  text: ride.to,
                  fontSize: 18,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w900,
                  color: ClrUtils.tertiary,
                ),
              ],
            ),
            CustomText(
              text: "Details",
              color: ClrUtils.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 10),
            CustomText(
              text:
                  "Departure Time: ${DateFormat('dd MMMM h:mm a').format(ride.dateTime)}",
              fontSize: 14,
              color: ClrUtils.textSecondary,
            ),
            CustomText(
              text: "Fare: ${ride.fare}",
              fontSize: 14,
              color: ClrUtils.textSecondary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  color: ClrUtils.textSecondary,
                ),
              ],
            ),
            CustomText(
              text: "Color: ${ride.carColor}",
              fontSize: 14,
              color: ClrUtils.textSecondary,
            ),
            isBookedTab
                ? CustomText(
                    text: "Owner: ${ride.owner}",
                    fontSize: 14,
                    color: ClrUtils.textSecondary,
                  )
                : CustomText(
                    text:
                        "Booked By: ${ride.bookedBy.isNotEmpty ? ride.bookedBy.join(', ') : "none"}",
                    fontSize: 14,
                    color: ClrUtils.textSecondary,
                  )
          ],
        ),
      ),
    );
  }
}
