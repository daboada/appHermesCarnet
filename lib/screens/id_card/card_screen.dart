import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CardScreen extends StatelessWidget {

  final String role;
  final String name;
  final String lastname;
  final int numDocument;
  final String typeBlood;
  final String token;
  final String username;

  final List<String> imageList = [];

  CardScreen({
    super.key, // Agrega el parámetro Key al constructor.
    required this.role,
    required this.name,
    required this.lastname,
    required this.numDocument,
    required this.typeBlood,
    required this.token,
    required this.username,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // TITULOS
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  children: [
                    // TITULO HERMES
                    Text(
                      'Hermes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    // SEPARACION
                    SizedBox(height: MediaQuery.of(context).size.height * 0.009),
                    // SALUDO A LA PERSONA
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hola $name',
                        style: TextStyle(
                          color: const Color.fromRGBO(0, 49, 77, 1),
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    // ROL DE LA PERSONA
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        role,
                        style: TextStyle(
                            color: const Color.fromRGBO(121, 119, 119, 1.0),
                            fontSize: MediaQuery.of(context).size.height * 0.013,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // CODIGO QR
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                  child: PrettyQrView.data(
                    data: '{ token: $token, username: $username}',
                    decoration: const PrettyQrDecoration(
                      image: PrettyQrDecorationImage(
                        image: AssetImage('assets/images/card/logo_sena_blue.png'),
                      ),
                      background: Colors.white,
                      shape: PrettyQrRoundedSymbol(
                        color: Color(0xFF00324A), // COLOR BLUE IS GOOD
                        // color: Color(0xFF000000), // COLOR BLACK IS BETTER FOR THE SCANNER
                        borderRadius: BorderRadius.zero, // Set the corner radius
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // INFORMACIÓN PERSONA
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 49, 77, 1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: const Padding(
                  padding: const EdgeInsets.only(left: 5, top: 12, right: 5, bottom: 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text('Holaa', style: TextStyle(color: Colors.white),),
                                Text('Holaaa')
                              ],
                            ),
                            Column(
                              children: [
                                Text('Holaa'),
                                Text('Holaa'),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
 @override
 Path getClip(Size size) {
    final path = Path();    
    path.moveTo(0,size.height*0.0000043);
    path.lineTo(size.width*1.0015000,size.height*0.0001429);
    path.lineTo(size.width*1.0053333,size.height*0.9748571);
    path.lineTo(0,size.height*0.4748571);
    path.lineTo(0,size.height*0.0000143);
    path.lineTo(size.width, 0);
    path.close();
    return path;
 }

 @override
 bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
 }
}