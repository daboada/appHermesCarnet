import 'package:flutter/material.dart';
import 'package:hermes/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isImagePrecached = false;

  /* Funcion pantalla de carga */
  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 4);
    Future.delayed(duration, () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }), (route) => false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isImagePrecached) {
      precacheImage(
          const AssetImage("assets/images/login/background.webp"), context);
      _isImagePrecached = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(0, 49, 77, 1), // Color de fondo azul
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Agrega aquí tu imagen
              Image.asset(
                'assets/images/login/logo_sena.webp',
                width: 600, // Ancho de la imagen
                height: 600, // Alto de la imagen
              ),
              const SizedBox(
                  height: 20), // Espacio entre la imagen y otros elementos
              // Agrega otros widgets si es necesario
            ],
          ),
        ),
      ),
    );
  }
}
