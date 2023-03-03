import 'package:ecuafilms/controllers/sesion_controller.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  RegisterForm createState() => RegisterForm();
}

class RegisterForm extends State<Register> {
  bool mostrarPassword = false;
  final _formKey = GlobalKey<FormState>();
  final txtnombres = TextEditingController();
  final txtapellidos = TextEditingController();
  final txtcorreo = TextEditingController();
  final txtpassword = TextEditingController();

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
                children: [
                  text('Registro'),
                  espacio(15),
                  textFormField('Nombres', txtnombres, TextInputType.text,
                      Icons.person, 'Nombres', false, null, null),
                  espacio(15),
                  textFormField('Apellidos', txtapellidos, TextInputType.text,
                      Icons.person, 'Apellidos', false, null, null),
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
                  espacio(15),
                  regresarLogin(),
                ],
              ),
            ),
          ),
        )),
      ),
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
        if (mensaje == 'Nombres' && !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
          return 'Los nombres solo pueden contener letras';
        }
        if (mensaje == 'Apellidos' &&
            !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
          return 'Los apellidos solo pueden contener letras';
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
        onPressed: validacion,
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

  void validacion() {
    if (_formKey.currentState!.validate()) {
      Sesion().registrarseFireBase(txtnombres.text, txtapellidos.text,
          txtcorreo.text, txtpassword.text, context);
    }
  }

  Widget regresarLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('¿ya te encuentras registrado?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            )),
        const SizedBox(
          width: 5,
        ),
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'login');
            },
            child: const Text(
              'Login',
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
