import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i/features/auth/authentication/view/forget_password.dart';
import 'package:i/features/auth/authentication/view/login_view.dart';
import 'package:i/features/auth/authentication/view/user_name.dart';
import 'package:i/features/auth/introduction/view/introduction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/authentication/view/sigup_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Infinity',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        // home: IntroductionScreens(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return createRoute(IntroductionScreens());

            case '/login':
              return createRoute(LoginView());

            case '/username':
              return createRoute(
                  UsernamePage(email: settings.arguments as String));
            case '/signup':
              return createRoute(SignupView());

            case '/forgot-password':
              return createRoute(ForgetPasswordView());
            default:
              return createRoute(Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
          }
        });
  }
}

// Routing Animation
PageRouteBuilder createRoute(Widget destination) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return destination;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
