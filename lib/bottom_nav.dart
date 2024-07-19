import 'package:acadame/navpage/bot.dart';
import 'package:acadame/navpage/home.dart';
import 'package:acadame/navpage/me.dart';
import 'package:acadame/navpage/quizbank.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const QuizBank(),
    const BotPage(),
    const MePage(),
    // Add other pages here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(LineIcons.school),
            title: const Text('Learn'),
          ),
          FlashyTabBarItem(
            icon: const Icon(LineIcons.battleNet),
            title: const Text('Practice'),
          ),
          FlashyTabBarItem(
            icon: const Icon(LineIcons.chalkboardTeacher),
            title: const Text('Bot'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.school),
            title: const Text('Me'),
          ),
        ],
      ),
    );
  }
}
