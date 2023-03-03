import 'package:ecuafilms/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class MenuPelicula extends StatefulWidget {
  const MenuPelicula({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _Menu createState() => _Menu();
}

class _Menu extends State<MenuPelicula> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(user
    // ?.email); // se imprime el correo del usuario para verificar que usuario esta logueado
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          drawerHeader(),
          drawerItem(
              icon: Icons.movie,
              text: 'Peliculas', // se coloca peliculas
              onTap: () => Navigator.pushNamed(context, 'home')),
          drawerItem(
              icon: Icons.person,
              text: 'Perfil', //se coloca perfil
              onTap: () => Navigator.pushNamed(context, 'perfil_usuario')),
          drawerItem(
              icon: Icons.exit_to_app,
              text: 'Cerrar Sesión',
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp())));
              }),
        ],
      ),
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: Color(0xFF242A32),
        ),
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text(
              'Correo: ${user!.email}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 50),
            child: Text(
              'Id: ${user!.uid}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
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
