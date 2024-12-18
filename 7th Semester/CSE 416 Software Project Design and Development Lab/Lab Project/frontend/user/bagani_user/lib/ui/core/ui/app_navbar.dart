import 'package:bagani/ui/home/home_view.dart';
import 'package:bagani/ui/profile/profile_view.dart';
import 'package:bagani/ui/search/search_view.dart';
import 'package:bagani/ui/store/store_view.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavBarPage extends ConsumerStatefulWidget {
  final int userId; // Add userId as a parameter

  const BottomNavBarPage({Key? key, required this.userId}) : super(key: key);

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends ConsumerState<BottomNavBarPage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize the pages after the widget is available
    _pages = [
      const HomeView(),
      const SearchView(),
      StoreView(
        userId: widget.userId,
      ),
      ProfileView(
          profileId: widget.userId), // Use widget.userId to pass the userId
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show selected page
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.local_florist, size: 30), // For "My Plants"
          Icon(Icons.account_circle, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
