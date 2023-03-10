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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        tooltip: 'Regresar',
        mini: false,
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.863),
        child: const Icon(Icons.arrow_back, color: Colors.black87),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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
                  const SizedBox(
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
                  color: const Color.fromARGB(206, 158, 158, 158),
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
                      children: [
                        Icon(Icons.thumb_up,
                            color: const Color(0xFF0d6efd).withOpacity(0.8)),
                        const SizedBox(width: 10),
                        Icon(Icons.thumb_down,
                            color: const Color(0xFFdc3545).withOpacity(0.8)),
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
