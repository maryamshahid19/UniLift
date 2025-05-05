import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/models/ride.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/repositories/rides_repository.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/text/customText.dart';

class RideDetailPopup extends StatefulWidget {
  RideModel ride;
  UserModel user;

  RideDetailPopup({
    super.key,
    required this.ride,
    required this.user,
  });

  @override
  State<RideDetailPopup> createState() => _RideDetailPopupState();
}

class _RideDetailPopupState extends State<RideDetailPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ClrUtils.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: ClrUtils.icon, width: 3),
      ),
      child: Container(
        width: SizeCons.getWidth(context) * 0.9,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: "Are you sure to book?",
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ClrUtils.tertiary,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: widget.ride.from,
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
                  text: widget.ride.to,
                  fontSize: 18,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w900,
                  color: ClrUtils.tertiary,
                ),
              ],
            ),
            SizedBox(height: 3),
            CustomText(
              text: "${widget.ride.availableSeats} seat left",
              color: ClrUtils.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 10),
            CustomText(
              text:
                  "Departure Time: ${DateFormat('dd MMMM h:mm a').format(widget.ride.dateTime)}",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ClrUtils.tertiary,
            ),
            CustomText(
              text: "Fare: ${widget.ride.fare}",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ClrUtils.tertiary,
            ),
            SizedBox(height: 15),
            Divider(height: 2),
            SizedBox(height: 15),
            CustomText(
              text: "More Details",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ClrUtils.secondary,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/uber.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 5),
                CustomText(
                  text: widget.ride.carType,
                  fontSize: 14,
                  color: ClrUtils.textSecondary,
                ),
              ],
            ),
            SizedBox(height: 3),
            CustomText(
              text: "Owner: ${widget.ride.owner}",
              fontSize: 14,
              color: ClrUtils.textSecondary,
            ),
            SizedBox(height: 3),
            CustomText(
              text: "Plate No: ${widget.ride.carPlate}",
              fontSize: 14,
              color: ClrUtils.textSecondary,
            ),
            SizedBox(height: 3),
            CustomText(
              text: "Color: ${widget.ride.carColor}",
              fontSize: 14,
              color: ClrUtils.textSecondary,
            ),
            SizedBox(height: 15),
            CustomButton(
                text: "Confirm",
                onPressed: () async {
                  RidesRepository().bookCarpoolRide(widget.ride.documentId,
                      widget.ride.availableSeats - 1, widget.user.fullName);

                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
