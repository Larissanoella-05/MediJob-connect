import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // This will be generated

// Import all your pages
import 'app/tabs/home.dart';
import 'app/tabs/job_centre/job_centre.dart';
import 'app/tabs/education_centre/education_centre.dart';
import 'app/tabs/entrepreneurship_centre/entrepreneurship_centre.dart';
import 'app/tabs/network/network.dart';

// Import providers
import 'providers/job_provider.dart';
import 'providers/user_profile_provider.dart';
import 'providers/following_provider.dart';
import 'providers/theme_provider.dart';

// Import landing screen
import 'components/landing_animated.dart';

// Import login screen
import 'components/login.dart';

// Import forgot password screen
import 'components/forgot_password.dart';

// Import signup screen
import 'components/signup.dart';

// Import settings screen
import 'settings.dart';

// Import profile screens
import 'profile.dart';
import 'edit_profile.dart' show UserInfoScreen;

// Import constants
import 'constants/colors.dart';
import 'constants/theme.dart';

// Import OTP channel
import 'components/OTP.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => FollowingProvider()),
        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Medijobs Connect',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/forgot-password': (context) => const ForgotPasswordScreen(),
            '/otp': (context) => const OTPScreen(),
            '/home': (context) => const IndexPage(),
            '/settings': (context) => const SettingsScreen(),
            '/profile': (context) => ProfileScreen(),
            '/edit-profile': (context) => const UserInfoScreen(),
          },
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LandingAnimated(
      onAutoNavigate: () {
        // Navigate to login page after animation completes
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
    );
  }
}

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    JobCentreScreen(),
    EducationCentreScreen(),
    EntrepreneurshipCentreScreen(),
    NetworkingScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.brand,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.briefcase),
            label: 'Job Centre',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.graduationCap),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.lightbulb),
            label: 'Entrepreneur',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            label: 'Network',
          ),
        ],
      ),
    );
  }
}
