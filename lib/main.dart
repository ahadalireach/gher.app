// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'screens/homeScreen.dart';
import 'screens/aboutScreen.dart';
import 'screens/propertiesScreen.dart';
import 'screens/profileScreen.dart';

void main() {
  runApp(MyRealEstateApp());
}

class MyRealEstateApp extends StatefulWidget {
  @override
  _MyRealEstateAppState createState() => _MyRealEstateAppState();
}

class _MyRealEstateAppState extends State<MyRealEstateApp> {
  final List<Widget> _screens = [
    HomeScreen(),
    PropertiesScreen(),
    AboutScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Image.asset(
                'assets/headerLogo.png',
                fit: BoxFit.contain,
                height: 50,
              ),
            ),
            const Spacer(flex: 1),
            Flexible(
              flex: 5,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_city),
          label: 'Properties',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gher.com',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _screens[_selectedIndex],
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }
}
