import 'package:ecuafilms/controllers/sesion_controller.dart';
import 'package:ecuafilms/views/register_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginForm createState() => LoginForm();
}

class LoginForm extends State<Login> {
  bool mostrarPassword = false;
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
                      textFormField(
                          'Correo Electronico',
                          txtcorreo,
                          TextInputType.emailAddress,
                          Icons.email,
                          'Correo',
                          false,
                          null,
                          null),
                      espacio(15),
                      textFormField(
                          'Contraseña',
                          txtpassword,
                          TextInputType.visiblePassword,
                          Icons.lock,
                          'Contraseña',
                          true,
                          Icons.visibility_off,
                          Icons.visibility),
                      espacio(15),
                      _olvidastePassword(),
                      espacio(15),
                      _botonIngresar(),
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

  Widget textFormField(
      String texto,
      TextEditingController controller,
      keyboardType,
      IconData icono,
      String mensaje,
      bool valor,
      iconoPassword,
      iconoPasswordv) {
    return TextFormField(
      obscureText: mostrarPassword == false ? valor : false,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          fillColor: const Color.fromARGB(137, 255, 255, 255),
          hintText: texto,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(icono, color: Colors.black),
          suffixIcon: GestureDetector(
            child: Icon(
                mostrarPassword == false ? iconoPassword : iconoPasswordv,
                color: Colors.black),
            onTap: () {
              setState(() {
                mostrarPassword = !mostrarPassword;
              });
            },
          ),
          contentPadding: const EdgeInsets.only(top: 14.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su $mensaje';
        }
        if (mensaje == 'Correo' &&
            !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                .hasMatch(value)) {
          return 'Por favor ingrese un correo valido';
        }
        if (mensaje == 'Contraseña' && value.length < 6) {
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
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _botonIngresar() {
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
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future iniciarSesion() async {
    if (_formKey.currentState!.validate()) {
      Sesion().login(txtcorreo.text, txtpassword.text, context);
    }
  }

  Widget _crearCuenta(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Register()));
            },
            child: const Text(
              'Crear una cuenta',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
