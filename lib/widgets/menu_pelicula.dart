import 'package:ecuafilms/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser;

class MenuPelicula extends StatefulWidget {
  const MenuPelicula(User? user, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _Menu createState() => _Menu();
}

class _Menu extends State<MenuPelicula> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          drawerHeader(),
          drawerItem(
              icon: Icons.movie,
              text: 'Peliculas',
              onTap: () => Navigator.pushNamed(context, 'home')),
          drawerItem(
              icon: Icons.person,
              text: 'Perfil',
              onTap: () => Navigator.pushNamed(context, 'perfil_usuario')),
          drawerItem(
              icon: Icons.exit_to_app,
              text: 'Cerrar Sesión',
              onTap: () => cerrarSesion()),
        ],
      ),
    );
  }

  Future cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget drawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: Color(0xFF242A32),
        ),
        child: Stack(children: <Widget>[
          Text(
            (user!.email.toString()),
          ),
        ]));
  }

  Widget drawerItem(
      {IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
