import 'package:flutter/material.dart';

class DetallePelicula extends StatefulWidget {
  const DetallePelicula({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _Detalle createState() => _Detalle();
}

class _Detalle extends State<DetallePelicula> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF242A32),
        actions: const [],
      ),
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
