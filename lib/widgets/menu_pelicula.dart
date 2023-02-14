import 'package:ecuafilms/views/login.dart';
import 'package:flutter/material.dart';

class MenuPelicula extends StatelessWidget {
  const MenuPelicula({super.key});

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
              onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (Route<dynamic> route) => false,
                  )),
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
        child: Stack(children: const <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("EcuaFilms",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500))),
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
