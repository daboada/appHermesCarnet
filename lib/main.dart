import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hermes/provider/api_provider_user.dart';
import 'package:hermes/screens/splash/splash_screen.dart';
import 'package:hermes/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
 });
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProviderUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "splash",
        routes: {
          "splash": (context) => const SplashScreen(),
          "login": (context) => const LoginScreen(),
        },
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      ),
    );
 }
}
