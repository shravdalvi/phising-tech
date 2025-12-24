import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/education_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const VernacuGuardApp());
}

class VernacuGuardApp extends StatelessWidget {
  const VernacuGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
   MaterialApp(
  debugShowCheckedModeBanner: false,

  // ⭐ FORCE LIGHT MODE — NO SYSTEM OVERRIDE
  themeMode: ThemeMode.light,

  // ⭐ BASIC LIGHT THEME (OVERRIDES EVERYTHING)
  theme: ThemeData(
    brightness: Brightness.light,
    useMaterial3: false, // 🔴 VERY IMPORTANT
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  ),

  initialRoute: '/',
  routes: {
    '/': (context) => const SplashScreen(),
    '/home': (context) => const MainShell(),
  },
);

  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    EducationScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ⭐ Background that covers EVERYTHING
      backgroundColor: const Color(0xFFC7BFFF),

      body: SizedBox.expand( // ⭐ THIS IS THE REAL FIX
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: KeyedSubtree( // ⭐ forces correct rebuild & sizing
            key: ValueKey(index),
            child: screens[index],
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Analyze',
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
