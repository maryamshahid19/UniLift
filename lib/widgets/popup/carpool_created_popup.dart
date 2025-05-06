import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/models/ride.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/repositories/rides_repository.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/text/customText.dart';

class CarpoolCreatedPopup extends StatefulWidget {
  // RideModel ride;
  // UserModel user;

  CarpoolCreatedPopup({
    super.key,
    // required this.ride,
    // required this.user,
  });

  @override
  State<CarpoolCreatedPopup> createState() => _CarpoolCreatedPopupState();
}

class _CarpoolCreatedPopupState extends State<CarpoolCreatedPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ClrUtils.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: ClrUtils.icon, width: 3),
      ),
      child: Container(
        height: SizeCons.getHeight(context) * 0.3,
        width: SizeCons.getWidth(context) * 0.9,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/tick.png'),
              SizedBox(height: 5),
              CustomText(
                text: "Carpool Created!",
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: ClrUtils.tertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
