import 'package:ecuafilms/controllers/perfil_controller.dart';
import 'package:ecuafilms/models/usuario_model.dart';
import 'package:ecuafilms/widgets/menu_pelicula_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PerfilUsuario createState() => _PerfilUsuario();
}

class _PerfilUsuario extends State<PerfilUsuario> {
  final Perfil datosPerfil = Perfil();
  final formKey = GlobalKey<FormState>();
  final txtnombres = TextEditingController();
  final txtapellidos = TextEditingController();
  String? userId = FirebaseAuth.instance.currentUser!.uid;
  String? correo = FirebaseAuth.instance.currentUser!.email!;

  @override
  void initState() {
    super.initState();
    usuarioDatos();
  }

  Future<void> usuarioDatos() async {
    Usuario usuario = await datosPerfil.obtenerUsuario(userId!);
    txtnombres.text = usuario.nombres!;
    txtapellidos.text = usuario.apellidos!;
  }

  @override
  Widget build(BuildContext context) {
    String hash = datosPerfil.imagenHash(correo!);

    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[],
      ),
      drawer: const MenuPelicula(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 40),
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                children: [
                  text('Editar Perfil'),
                  espacio(16),
                  imagenPerfil(hash),
                  espacio(15),
                  textFormField('Nombres', txtnombres, TextInputType.text,
                      Icons.person, 'Nombres'),
                  espacio(15),
                  textFormField('Apellidos', txtapellidos, TextInputType.text,
                      Icons.person, 'Apellidos'),
                  espacio(15),
                  botonActualizar(),
                ],
              )),
        ),
      ),
    );
  }

  Widget imagenPerfil(String hash) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
              'https://www.gravatar.com/avatar/$hash?d=robohash&f=y&s=200'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget espacio(double alto) {
    return SizedBox(height: alto);
  }

  Widget text(String registro) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: Text(registro,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget textFormField(String texto, TextEditingController controller,
      keyboardType, IconData icono, String mensaje) {
    return TextFormField(
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
          contentPadding: const EdgeInsets.only(top: 14.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su $mensaje';
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

  Widget botonActualizar() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFffc107).withOpacity(0.9).withBlue(60),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: validacion,
          child: const Text('Actualizar',
              style: TextStyle(fontSize: 15, color: Colors.black)),
        ));
  }

  void validacion() {
    if (formKey.currentState!.validate()) {
      datosPerfil.actualizarUsuario(
          userId!, txtnombres.text, txtapellidos.text, context);
    }
  }
}
