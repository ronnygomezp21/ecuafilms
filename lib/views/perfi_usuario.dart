import 'package:ecuafilms/widgets/menu_pelicula.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final User? user = FirebaseAuth.instance.currentUser;

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PerfilUsuario createState() => _PerfilUsuario();
}

class _PerfilUsuario extends State<PerfilUsuario> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[],
      ),
      drawer: MenuPelicula(user),
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
        child: Column(
          children: const <Widget>[
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
