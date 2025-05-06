import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/models/user.dart';

import 'package:unilift/screens/createCarpoolScreens/car_details_screen.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/text/customText.dart';

class CarpoolDetailScreen extends StatefulWidget {
  CarpoolDetailScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<CarpoolDetailScreen> createState() => _CarpoolDetailScreenState();
}

class _CarpoolDetailScreenState extends State<CarpoolDetailScreen> {
  int selectedSeat = 1;
  bool goingToUniversity = true;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final TextEditingController _locationController = TextEditingController();

  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });

      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          selectedTime = pickedTime;
        });
      }
    }
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
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStepCircle(1, isSelected: true),
                        _buildDashedLine(),
                        _buildStepCircle(2),
                        _buildDashedLine(),
                        _buildStepCircle(3),
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
                        const Text("Trip",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const SizedBox(height: 16),
                        _buildLocationRow(
                          "Pick Up",
                          goingToUniversity
                              ? null
                              : widget.user.university ?? "Loading...",
                          isEditable: goingToUniversity,
                        ),
                        const SizedBox(height: 16),
                        _buildLocationRow(
                          "Drop Off",
                          goingToUniversity
                              ? widget.user.university ?? "Loading..."
                              : null,
                          isEditable: !goingToUniversity,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(goingToUniversity
                                ? "To University"
                                : "From University"),
                            SizedBox(width: 10),
                            Switch(
                              value: goingToUniversity,
                              onChanged: (val) {
                                setState(() => goingToUniversity = val);
                              },
                              activeColor: Colors.black,
                            ),
                          ],
                        ),
                        const Divider(
                          height: 40,
                          color: ClrUtils.border,
                        ),
                        const CustomText(
                            text: "Seat and Time",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "\u2022  Available Seats",
                                fontSize: 15,
                                color: ClrUtils.tertiary,
                                fontWeight: FontWeight.w600,
                              ),
                              Row(
                                children: List.generate(4, (index) {
                                  final seat = index + 1;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: ChoiceChip(
                                      label: Text(seat.toString()),
                                      selected: selectedSeat == seat,
                                      onSelected: (_) {
                                        setState(() => selectedSeat = seat);
                                      },
                                      selectedColor: Colors.black,
                                      backgroundColor: Colors.grey.shade200,
                                      labelStyle: TextStyle(
                                        color: selectedSeat == seat
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ]),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "\u2022  Date and Time",
                              fontSize: 15,
                              color: ClrUtils.tertiary,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _pickDateTime,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year} ${selectedTime.format(context)}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.calendar_today),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: "Continue",
                          onPressed: () {
                            if ((goingToUniversity &&
                                    _locationController.text.trim().isEmpty) ||
                                (!goingToUniversity &&
                                    _locationController.text.trim().isEmpty)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please enter location")),
                              );
                              return;
                            }

                            String from = goingToUniversity
                                ? _locationController.text.trim()
                                : widget.user.university ?? "Unknown";

                            String to = goingToUniversity
                                ? widget.user.university ?? "Unknown"
                                : _locationController.text.trim();

                            DateTime tripDateTime = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarDetailScreen(
                                  user: widget.user,
                                  dateTime: tripDateTime,
                                  availableSeats: selectedSeat,
                                  from: from,
                                  to: to,
                                ),
                              ),
                            );
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
        child: CustomText(
          text: step.toString(),
          color: isSelected ? ClrUtils.primary : Colors.black,
          fontWeight: FontWeight.bold,
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

  Widget _buildLocationRow(String label, String? value,
      {bool isEditable = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(41, 255, 110, 97),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: label, fontSize: 12, color: Colors.black54),
                isEditable
                    ? TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          hintText: "Enter location in Karachi",
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      )
                    : CustomText(
                        text: value ?? "",
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
