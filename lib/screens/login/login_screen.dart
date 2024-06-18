import 'package:flutter/material.dart';
import 'package:hermes/provider/api_provider_user.dart';
import 'package:hermes/screens/id_card/card_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
// import 'package:hermes/screens/id_card/card_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email = '';
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;

  late int estadoLogeo;
  bool estadoConnection = true; //Para simular cuando se tenga conexion

  @override
  void initState() {
    super.initState();
    estadoLogeo = (email == "") ? 0 : 1;
    _controllerEmail = TextEditingController(text: email);
    _controllerPassword = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  } // Para mostrar los datos del input en consola

  //Funcion para mostrar el mensaje de error
  void mostrarErrorDialog(BuildContext context, message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  color: const Color.fromRGBO(251, 7, 7, 1),
                  size: MediaQuery.of(context).size.width * 0.2,
                ),
                Text(
                  'Oops!',
                  style: TextStyle(
                      color: const Color.fromRGBO(251, 7, 7, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          content: SizedBox(
            height:
                MediaQuery.of(context).size.width * 0.3, // Altura agregada
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centra los widgets de texto verticalmente
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: const Color.fromRGBO(251, 7, 7, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox( height: 20 ),
                  Text(
                    'Para mas información ingresar a www.hermes.com', // Aquí puedes agregar tu segundo texto
                    style: TextStyle(
                      color: const Color.fromARGB(255, 113, 119, 121), // Puedes cambiar el estilo del segundo texto como desees
                      fontSize: MediaQuery.of(context).size.width * 0.028, // Ajusta el tamaño del texto según sea necesario
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 49, 77, 1), // Color de fondo del botón
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados (opcional)
                ),
                height: MediaQuery.of(context).size.width * 0.1,
                child: TextButton(
                  child: Text(
                    'Intentar de nuevo',
                    style: TextStyle(
                        color: Colors.white, // Color del texto (opcional)
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        //Para que se quede fijo el contenido usar SingleChildScrollView y no haya alteracion al momento que sale el teclado del celular
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    width: MediaQuery.of(context).size.width, // Ancho de la pantalla
                    height: MediaQuery.of(context).size.height, // Altura de la pantalla
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/login/background.webp"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: ClipPath(
                    // Usar ClipPath con CustomClipper para la forma personalizada
                    clipper: MyCustomClipper(),
                    child: Container(
                      color: const Color.fromRGBO(0, 49, 77, 1),
                      height: MediaQuery.of(context).size.width * 1.2,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.width * 0.1),
                            Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05),
                                Text(
                                  estadoConnection  ? 'En linea' : 'Desconectado',
                                  style: TextStyle(
                                      color: estadoConnection ? const Color.fromRGBO(12, 251, 7, 1)  : const Color.fromRGBO(251, 7, 7, 1),
                                      fontSize: MediaQuery.of(context).size.width * 0.04),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.03),
                                Icon(
                                  Icons.wifi_rounded,
                                  color: estadoConnection ? const Color.fromRGBO(12, 251, 7, 1) : const Color.fromRGBO(251, 7, 7, 1),
                                )
                              ],
                            ),
                            SizedBox( height: MediaQuery.of(context).size.width * 0.05 ),
                            Image.asset("assets/images/login/logo_sena.webp"),
                            Text('Transformando vidas\n construyendo futuro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width * 0.06,
                                  fontWeight: FontWeight.w400)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      estadoLogeo == 0 || estadoLogeo == 1 ? TextFormField(
                              controller: _controllerEmail,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10), // Radio del borde
                                  borderSide: const BorderSide(
                                    // Propiedades del borde
                                    color: Colors.black, // Color del borde
                                    width: 2, // Grosor del borde
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                                hintText: 'Correo electronico',
                                prefixIcon: const Icon(Icons.email),
                              ),
                              style: TextStyle(
                                  height: MediaQuery.of(context).size.width * 0.003,
                                  fontSize: MediaQuery.of(context).size.width * 0.035),
                            )
                          : Container(),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.05),
                          estadoLogeo == 0 || estadoLogeo == 2 ? TextFormField(
                              controller: _controllerPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10), // Radio del borde
                                  borderSide: const BorderSide(
                                    // Propiedades del borde
                                    color: Colors.black, // Color del borde
                                    width: 2, // Grosor del borde
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                                hintText: 'Contraseña',
                                prefixIcon: const Icon(Icons.key),
                              ),
                              style: TextStyle(
                                  height: MediaQuery.of(context).size.width * 0.003,
                                  fontSize: MediaQuery.of(context).size.width * 0.035),
                                  obscureText: true,
                              )
                          : Container(),
                            SizedBox( height: MediaQuery.of(context).size.width * 0.05),
                      ElevatedButton(
                        onPressed: () async {

                          /* Validaciones */

                          bool isValidEmail(String email) {
                              final RegExp regex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9-]+\.)+(?:misena\.edu\.co|sena\.edu\.co|soy\.sena\.edu\.co)$');
                              return regex.hasMatch(email);
                          }

                          if (_controllerEmail.text.isEmpty || _controllerPassword.text.isEmpty) 
                          {
                            mostrarErrorDialog(context, 'Por favor ingresa el correo electronico y contraseña.');
                          }
                          else if (_controllerEmail.text.length >= 50 || _controllerPassword.text.length >= 25 ) {
                            mostrarErrorDialog(context, 'El correo electronico o contraseña ingresados no son validos');
                          }
                          else if (!isValidEmail(_controllerEmail.text))
                          {
                            mostrarErrorDialog(context, 'El correo electronico ingresado no es valido.');
                          }
                          else if (_controllerPassword.text.length < 8 || _controllerPassword.text.length > 20)
                          {
                            mostrarErrorDialog(context, 'La información ingresada no es valida, por favor revise la información ingresada e intentelo nuevamente');
                          } 
                          else 
                          {

                            // CALL THE PROVIDER TO VALIDATE USER
                            final apiProviderUser = Provider.of<ApiProviderUser>(context, listen: false);
                            Map<String, dynamic> result = await apiProviderUser.loginUser(_controllerEmail.text, _controllerPassword.text);

                            // IF API PROVIDER RETURN A 200 PASS TO REQUEST DATA USER
                            if (result['statusCode'] == 200) {

                              // DECODE TOKEN
                              Map<String, dynamic> decodedToken = JwtDecoder.decode(result['body']['token']);

                              // MADE THE URL FOR THE REQUEST
                              String userName = result['body']['username'].toString();

                              // CALL THE PROVIDER TO USER DATA
                              Map<String, dynamic> resultDataUser = await apiProviderUser.dataUser(userName, result['body']['token'].toString());



                              // PASS THE DATA TO CARD VIEW
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CardScreen(
                                    role: decodedToken['roles'].toString(),
                                    name: resultDataUser['body']['name'].toString(),
                                    lastname: resultDataUser['body']['surname'].toString(),
                                    numDocument: resultDataUser['body']['document'],
                                    typeBlood: resultDataUser['body']['blood_type'].toString(),
                                    token: result['body']['token'].toString(),
                                    username: result['body']['username'].toString(),
                                  )
                                )
                              );
                              
                            } 
                            else if (result['statusCode'] != 200) 
                            {                             
                              mostrarErrorDialog(context, 'Error al iniciar sesión, el corrreo electroico o contraseña no son validos');
                            } 
                            else 
                            {                             
                              mostrarErrorDialog(context, 'Error al iniciar sesión');
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(0, 49, 77, 1)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05)),
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text('Iniciar Sesión'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.0000043);
    path.lineTo(size.width * 1.0015000, size.height * 0.0001429);
    path.lineTo(size.width * 1.0053333, size.height * 0.6748571);
    path.quadraticBezierTo(size.width * 0.7482500, size.height * 0.6084286,
        size.width * 0.5110000, size.height * 0.8011429);
    path.quadraticBezierTo(size.width * 0.2975417, size.height * 1.0072857,
        size.width * 0, size.height * 0.8394286);
    path.lineTo(0, size.height * 0.0000143);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
