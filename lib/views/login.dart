import 'package:ecuafilms/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginForm createState() => LoginForm();
}

class LoginForm extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final txtusuario = TextEditingController();
  final txtpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fondo_1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black54,
                  BlendMode.darken,
                ),
              ),
            ),
            child: Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Form(
                  key: _formKey,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _logo(),
                      _espacio(),
                      _textFormFielUsuario(txtusuario),
                      _espacio(),
                      _textFormFielPassword(txtpassword),
                      _espacio(),
                      _olvidastePassword(),
                      _espacio(),
                      _botonIngresar(
                        context,
                        _formKey,
                        txtusuario,
                        txtpassword,
                      ),
                      _espacio(),
                      _crearCuenta(context),
                    ],
                  ),
                ),
              ),
            ))));
  }

  Widget _espacio() {
    return const SizedBox(
      height: 15,
    );
  }

  Widget _logo() {
    return Image.asset(
      'assets/img/logo.png',
      height: 40,
      width: 250,
    );
  }

  Widget _textFormFielUsuario(txtusuario) {
    return TextFormField(
      controller: txtusuario,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: const Color.fromARGB(137, 255, 255, 255),
        hintText: 'Usuario',
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.only(top: 14.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su usuario';
        }
        return null;
      },
    );
  }

  Widget _textFormFielPassword(txtpassword) {
    return TextFormField(
      obscureText: true,
      controller: txtpassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: const Color.fromARGB(137, 255, 255, 255),
        hintText: 'Contraseña',
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.only(top: 14.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su contraseña';
        }
        /*if (value.length < 6) {
        return 'La contraseña debe tener al menos 6 caracteres';
      }*/
        return null;
      },
    );
  }

  Widget _olvidastePassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        SizedBox(
          width: 5,
        ),
        Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _botonIngresar(
    BuildContext context,
    formKey,
    txtusuario,
    txtpassword,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 95, 142, 181),
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            /*FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: txtusuario.text, password: txtpassword.text)
                .then((value) => {
                      if (value.user != null)
                        {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (Route<dynamic> route) => false,
                          ),
                          if (kDebugMode)
                            {
                              // ignore: prefer_interpolation_to_compose_strings
                              print(
                                  '${'El usuario ' + txtusuario.text} se ha logueado.'),
                            }
                        }
                      else
                        {
                          if (kDebugMode)
                            {
                              print('Usuario o contraseña incorrectos'),
                            }
                        }*/
            validarUsuario(txtusuario, txtpassword, context);
          }
        },
        child: const Text(
          'Ingresar',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void validarUsuario(txtusuario, txtpassword, context) {
    if (txtusuario.text != '' && txtpassword.text != '') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (Route<dynamic> route) => false,
      );
      if (kDebugMode) {
        // ignore: prefer_interpolation_to_compose_strings
        print('${'El usuario ' + txtusuario.text} se ha logueado.');
      }
    } else {
      if (kDebugMode) {
        print('Usuario o contraseña incorrectos');
      }
    }
  }

  Widget _crearCuenta(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'register');
            },
            child: const Text(
              'Crear una cuenta',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )),
        const SizedBox(
          width: 5,
        ),
        InkWell(
            onTap: () {
              //Navigator.pushNamed(context, '');
            },
            child: const Text(
              '¿Necesitas ayuda?',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
