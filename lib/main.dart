import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// Import our custom files
import 'view/screens/splash_screen.dart';
import 'view/screens/auth/login_screen.dart';
import 'view/screens/auth/register_screen.dart';
import 'view/screens/home/home_screen.dart';
import 'view/screens/profile/profile_screen.dart';
import 'view/screens/bookings/bookings_screen.dart';
import 'utilities/theme.dart';
import 'controller/auth_controller.dart';
import 'controller/booking_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Stripe
  Stripe.publishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';
  await Stripe.instance.applySettings();
  
  // Initialize shared preferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
      ],
      child: GetMaterialApp(
        title: 'Salon Booking App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/bookings': (context) => const BookingsScreen(),
        },
      ),
    );
  }
}
