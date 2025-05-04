import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<IconData> _icons = const [
    Icons.home,
    Icons.access_time,
    Icons.add,
    Icons.person_outline,
  ];

  final List<String> _labels = const [
    "Rides",
    "Notifications",
    "Add",
    "Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: ClrUtils.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: ClrUtils.textTertiary,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      items: List.generate(_icons.length, (index) {
        return BottomNavigationBarItem(
          icon: Column(
            children: [
              if (currentIndex == index)
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: ClrUtils.textTertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              SizedBox(height: 5),
              Icon(_icons[index], size: 28),
            ],
          ),
          label: _labels[index],
        );
      }),
    );
  }
}
