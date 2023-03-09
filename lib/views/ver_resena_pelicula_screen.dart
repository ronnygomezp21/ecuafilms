import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerResenaPeliculaScreen extends StatefulWidget {
  const VerResenaPeliculaScreen({super.key});

  @override
  State<VerResenaPeliculaScreen> createState() =>
      _VerResenaPeliculaScreenState();
}

class _VerResenaPeliculaScreenState extends State<VerResenaPeliculaScreen> {
  @override
  Widget build(BuildContext context) {
    Map? argumentos = ModalRoute.of(context)?.settings.arguments as Map?;
    //print(argumentos!['id_pelicula']);
    return Scaffold(
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
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 25, left: 15, right: 15, bottom: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(argumentos!['titulo'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: cargarDatosDeUnoAMuchos(
                        argumentos['id_pelicula'].toString()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data,
                        );
                      } else if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future cargarDatosDeUnoAMuchos(String idPelicula) async {
    final CollectionReference resenas =
        FirebaseFirestore.instance.collection('reseñas');
    final QuerySnapshot querySnapshot = await resenas.get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var element in querySnapshot.docs) {
        String id = element.get('idPelicula');

        if (id == idPelicula) {
          return [
            for (var element in querySnapshot.docs)
              if (element.get('idPelicula') == idPelicula)
                Card(
                  elevation: 10,
                  color: Color.fromRGBO(158, 158, 158, 0.726),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(Icons.person,
                            color: Color.fromARGB(232, 255, 255, 255))),
                    title: Text(
                      element.get('descripcion'),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.thumb_up, color: Colors.black),
                        SizedBox(width: 10),
                        Icon(Icons.thumb_down, color: Colors.black)
                      ],
                    ),
                  ),
                ),
          ];
        }
      }
    }
  }
}
