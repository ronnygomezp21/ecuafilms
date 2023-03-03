import 'package:another_flushbar/flushbar.dart';
import 'package:ecuafilms/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginForm createState() => LoginForm();
}

class LoginForm extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final txtcorreo = TextEditingController();
  final txtpassword = TextEditingController();

  @override
  void dispose() {
    txtcorreo.dispose();
    txtpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/fondo_1.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.darken)),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      logo('assets/img/logo.png'),
                      espacio(15),
                      _textFormFieldCorreo(txtcorreo),
                      espacio(15),
                      _textFormFielPassword(txtpassword),
                      espacio(15),
                      _olvidastePassword(),
                      espacio(15),
                      _botonIngresar(context, _formKey, txtcorreo, txtpassword),
                      espacio(15),
                      _crearCuenta(context)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget espacio(double alto) {
    return SizedBox(height: alto);
  }

  Widget logo(String ruta) {
    return Image.asset(ruta, height: 40, width: 250);
  }

  Widget _textFormFieldCorreo(txtcorreo) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: txtcorreo,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: const Color.fromARGB(137, 255, 255, 255),
        hintText: 'Correo Electronico',
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
          Icons.email,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.only(top: 14.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su correo electrónico';
        }
        if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(value)) {
          return 'Por favor ingrese un correo electrónico válido';
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
        if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
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
    txtcorreo,
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
        onPressed: iniciarSesion,
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

  Future iniciarSesion() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: txtcorreo.text.trim().toString(),
                password: txtpassword.text.trim().toString())
            .then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Home())));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          Flushbar(
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            message: 'correo o contraseña incorrectos.',
            duration: const Duration(seconds: 3),
            backgroundColor: const Color(0xFFDC3545),
          ).show(context);
        }
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
