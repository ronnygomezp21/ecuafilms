import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ecuafilms/controllers/perfil_controller.dart';
import 'package:ecuafilms/main.dart';
import 'package:ecuafilms/views/home_screen.dart';
import 'package:ecuafilms/views/perfi_usuario_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuPelicula extends StatefulWidget {
  const MenuPelicula({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _Menu createState() => _Menu();
}

class _Menu extends State<MenuPelicula> {
  final Perfil datosPerfil = Perfil();
  final User? userFirebase = FirebaseAuth.instance.currentUser;
  String? correo = FirebaseAuth.instance.currentUser!.email!;

  @override
  void initState() {
    super.initState();
    userFirebase;
  }

  @override
  Widget build(BuildContext context) {
    String hash = datosPerfil.imagenHash(correo!);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF242A32)),
            accountName: const Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              userFirebase!.email.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://www.gravatar.com/avatar/$hash?d=robohash&f=y&s=200'),
            ),
          ),
          drawerItem(
              icon: Icons.movie,
              text: 'Peliculas',
              onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (Route<dynamic> route) => false,
                  )),
          drawerItem(
              icon: Icons.person,
              text: 'Perfil',
              onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PerfilUsuario()),
                    (Route<dynamic> route) => false,
                  )),
          drawerItem(
              icon: Icons.exit_to_app,
              text: 'Cerrar Sesión',
              onTap: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                          (Route<dynamic> route) => false,
                        ));
              }),
        ],
      ),
    );
  }

  Widget drawerItem({IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text!),
      onTap: onTap,
    );
  }
}
