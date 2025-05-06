import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/repositories/rides_repository.dart';
import 'package:unilift/screens/createCarpoolScreens/carpool_summary_screen.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/text/customText.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({
    super.key,
    required this.user,
    required this.dateTime,
    required this.availableSeats,
    required this.from,
    required this.to,
  });

  final UserModel user;
  final DateTime dateTime;
  final int availableSeats;
  final String from;
  final String to;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  String? carName;
  String? carColor;
  final plateController = TextEditingController();

  int fare = 100;

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
                        const Text(
                          "Add Car Details",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _dropdownField(
                                hint: "Car Type",
                                value: carName,
                                items: ['Toyota', 'Suzuki', 'Kia', 'Other'],
                                onChanged: (val) =>
                                    setState(() => carName = val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _plateField(
                                hint: "Car No.plate",
                                controller: plateController,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _dropdownField(
                                hint: "Car Color",
                                value: carColor,
                                items: [
                                  'Black',
                                  'White',
                                  'Grey',
                                  'Blue',
                                  'Red',
                                  'Other'
                                ],
                                onChanged: (val) =>
                                    setState(() => carColor = val),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 40, color: ClrUtils.border),
                        const CustomText(
                          text: "Set Fare",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Fare: ",
                                style: TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Text("Rs $fare",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ClrUtils.tertiary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () => setState(() => fare += 10),
                                    icon: const Icon(Icons.add,
                                        color: ClrUtils.primary),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ClrUtils.icon,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () => setState(
                                        () => fare = (fare - 10).clamp(0, 999)),
                                    icon: const Icon(Icons.remove,
                                        color: ClrUtils.tertiary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: "Continue",
                          onPressed: () {
                            String plate = plateController.text.trim();
                            final plateRegex = RegExp(r'^[A-Za-z]{3}[0-9]{3}$');

                            if (!plateRegex.hasMatch(plate) ||
                                carName == null ||
                                carColor == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please fill all car details correctly.\nNo.Plate Format: ABC123"),
                                ),
                              );
                              return;
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CarpoolSummaryScreen(
                                    user: widget.user,
                                    dateTime: widget.dateTime,
                                    availableSeats: widget.availableSeats,
                                    from: widget.from,
                                    to: widget.to,
                                    fare: fare,
                                    carName: carName!,
                                    carColor: carColor!,
                                    plate: plate,
                                  ),
                                ),
                              );
                            }
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

  Widget _plateField({
    required String hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      maxLength: 6,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
      ],
      decoration: InputDecoration(
        hintText: hint,
        counterText: '',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: ClrUtils.background,
      ),
    );
  }

  Widget _dropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ClrUtils.border)),
        filled: true,
        fillColor: ClrUtils.background,
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
