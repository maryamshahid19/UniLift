import 'package:flutter/material.dart';
import 'package:unilift/models/user.dart';
import 'package:unilift/repositories/auth_repository.dart';
import 'package:unilift/screens/createCarpoolScreens/carpool_details_screen.dart';
import 'package:unilift/screens/dashboard.dart';
import 'package:unilift/screens/history_screen.dart';
import 'package:unilift/screens/profile_screen.dart';
import 'package:unilift/widgets/navBar/customNavBar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late UserModel user;

  List<Widget> _screens = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    user = await AuthRepository().getCurrentUser();
    setState(() {
      _screens = [
        Dashboard(user: user),
        CarpoolHistoryScreen(user: user),
        CarpoolDetailScreen(user: user),
        ProfileScreen(),
      ];
    });
  }

  void goToProfile() {
    setState(() {
      _selectedIndex = 3;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
