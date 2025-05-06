import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/mainlayout.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/repositories/rides_repository.dart';
import 'package:unilift/screens/createCarpoolScreens/car_details_screen.dart';
import 'package:unilift/screens/createCarpoolScreens/carpool_details_screen.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/popup/carpool_created_popup.dart';
import 'package:unilift/widgets/text/customText.dart';

class CarpoolSummaryScreen extends StatefulWidget {
  const CarpoolSummaryScreen({
    super.key,
    required this.user,
    required this.dateTime,
    required this.availableSeats,
    required this.from,
    required this.to,
    required this.carName,
    required this.carColor,
    required this.plate,
    required this.fare,
  });

  final UserModel user;
  final DateTime dateTime;
  final int availableSeats;
  final String from;
  final String to;
  final String carName;
  final String carColor;
  final String plate;
  final int fare;

  @override
  State<CarpoolSummaryScreen> createState() => _CarpoolSummaryScreenState();
}

class _CarpoolSummaryScreenState extends State<CarpoolSummaryScreen> {
  showCarpoolCreationPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CarpoolCreatedPopup();
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
              Container(
                width: SizeCons.getWidth(context),
                height: SizeCons.getHeight(context) * 0.25,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(color: ClrUtils.secondary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomText(
                          text: "Create Carpool",
                          color: ClrUtils.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStepCircle(1, isSelected: true),
                        _buildDashedLine(),
                        _buildStepCircle(2, isSelected: true),
                        _buildDashedLine(),
                        _buildStepCircle(3, isSelected: true),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: SizeCons.getHeight(context) * 0.18,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ClrUtils.primary,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Summary",
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          text: widget.user.fullName,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: widget.user.email,
                          fontSize: 14,
                          color: ClrUtils.textSecondary,
                        ),
                        CustomText(
                          text: widget.user.university,
                          fontSize: 14,
                          color: ClrUtils.textSecondary,
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(width: 8),
                            CustomText(
                                text: "Pick Up", fontWeight: FontWeight.bold),
                          ],
                        ),
                        CustomText(text: widget.from),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_city_outlined),
                            const SizedBox(width: 8),
                            CustomText(
                                text: "University",
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        CustomText(text: widget.to),
                        const Divider(height: 40),
                        CustomText(
                          text: "Car details",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Car Name"),
                            CustomText(text: widget.carName ?? "-"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Number Plate"),
                            CustomText(text: widget.plate),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Car Color"),
                            CustomText(text: widget.carColor ?? "-"),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Available Seats"),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomText(
                                  text: widget.availableSeats.toString()),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Date and time"),
                            CustomText(text: "${widget.dateTime}"),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: "Confirm",
                          onPressed: () {
                            RidesRepository().createCarpool(
                                widget.from,
                                widget.to,
                                widget.dateTime,
                                widget.availableSeats,
                                widget.fare,
                                widget.carName,
                                widget.carColor,
                                widget.plate,
                                widget.user.fullName);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainLayout()));

                            showCarpoolCreationPopup();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(int step, {bool isSelected = false}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : ClrUtils.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: TextStyle(
            color: isSelected ? ClrUtils.primary : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDashedLine() {
    return Container(
      width: 80,
      height: 2,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: ClrUtils.primary, width: 1, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
