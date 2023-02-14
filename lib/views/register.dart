import 'package:ecuafilms/views/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //final _key = GlobalKey<FormState>();
  //final txtcorreo = TextEditingController();
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
  final _formKey = GlobalKey<FormState>();
  final txtnombre = TextEditingController();
  final txtapellido = TextEditingController();
  String? msj;
  //RegisterForm({Key: Register}) : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(
                  color: Color.fromRGBO(0, 96, 128, 1),
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color.fromRGBO(0, 96, 128, 1))),
                child: Center(
                  child: TextFormField(
                    controller: txtnombre,
                    validator: (value) {
                      if (value!.isEmpty) {
                        msj = 'Por favor ingrese su nombre';
                      } else {
                        msj = null;
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color.fromRGBO(0, 96, 128, 1))),
                child: Center(
                  child: TextFormField(
                    controller: txtapellido,
                    validator: (value) {
                      if (value!.isEmpty) {
                        msj = 'Por favor ingrese su apellido';
                      } else {
                        msj = null;
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('VALIDATE'),
                onPressed: () {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void mostrarAlerta(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registro'),
          content: const Text('Registro exitoso'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (Route<dynamic> route) => false,
              ),
            )
          ],
        );
      });
}

Widget textFormCorreo(txtcorreo) {
  return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(137, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: txtcorreo,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black,
          ),
          hintText: 'Ingrese su correo',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor ingrese su correo';
          }
          if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                  .hasMatch(value) ==
              false) return 'Por favor ingrese un correo valido';
          return null;
        },
      ));
}
