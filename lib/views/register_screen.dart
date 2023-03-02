import 'package:another_flushbar/flushbar.dart';
import 'package:ecuafilms/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  RegisterForm createState() => RegisterForm();
}

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _textFormCorreo(txtcorreo),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese su apellido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese su correo';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        //Navigator.pushNamed(context, 'home');
                        _mostrarAlerta(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            //color: Color.fromARGB(255, 175, 191, 203),
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
            padding: const EdgeInsets.all(15),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          child: const Icon(Icons.arrow_back),
        ));
  }*/
class RegisterForm extends State<Register> {
  bool mostrarPassword = false;
  final _formKey = GlobalKey<FormState>();
  final txtcorreo = TextEditingController();
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text('Registro'),
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
                botonIngresar(_formKey),
              ],
            ),
          ),
        ),
      )),
    ));
  }

  Widget espacio(double alto) {
    return SizedBox(
      height: alto,
    );
  }

  Widget text(String registro) {
    return Text(
      registro,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
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
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: const Color.fromARGB(137, 255, 255, 255),
        hintText: texto,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(
          icono,
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            mostrarPassword == false ? iconoPassword : iconoPasswordv,
            color: Colors.black,
          ),
          onTap: () {
            setState(() {
              mostrarPassword = !mostrarPassword;
            });
          },
        ),
        contentPadding: const EdgeInsets.only(top: 14.0),
      ),
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

  Widget botonIngresar(formKey) {
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
        onPressed: registrarse,
        child: const Text(
          'Registrarse',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future registrarse() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: txtcorreo.text.trim(),
              password: txtpassword.text.trim(),
            )
            .then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyApp())));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Flushbar(
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            message: 'El correo ya esta en uso.',
            duration: const Duration(seconds: 3),
            backgroundColor: const Color(0xFFDC3545),
          ).show(context);
        } else {
          Flushbar(
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            message: 'Error al registrarse, intentalo de nuevo.',
            duration: const Duration(seconds: 3),
            backgroundColor: const Color(0xFFDC3545),
          ).show(context);
        }
      }
    }
  }
}
