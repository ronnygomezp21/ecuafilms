import 'dart:async';

//import 'dart:convert';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecuafilms/api/api.dart';
import 'package:ecuafilms/controllers/pelicula_controller.dart';
import 'package:ecuafilms/models/detalle_pelicula_model.dart';

import 'package:flutter/material.dart';

const image = Api.imageBaseUrl;

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
    Size size = MediaQuery.of(context).size;
    final Object? idPelicula = ModalRoute.of(context)?.settings.arguments;
    Future<Welcome> detallePelicula =
        PeliculaController().obtenerDetallePelicula(idPelicula);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        tooltip: 'Regresar',
        mini: true,
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.863),
        child: const Icon(Icons.arrow_back, color: Colors.black87),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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
        child: FutureBuilder<Welcome>(
          future: detallePelicula,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => LayoutBuilder(builder:
                          (BuildContext context,
                              BoxConstraints viewportConstraints) {
                        return Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.4,
                              child: Stack(
                                children: [
                                  Container(
                                    height: size.height * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${image}original${snapshot.data!.backdropPath}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: size.height * 0.5,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Color.fromARGB(183, 0, 0, 0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            itemDetallesPelicula(
                                15,
                                15,
                                0,
                                0,
                                '${snapshot.data!.title}',
                                20,
                                FontWeight.bold,
                                TextAlign.left),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      '${snapshot.data!.voteAverage}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            listadoGeneroPelicula(size, snapshot),
                            itemDetallesPelicula(15, 0, 0, 0, 'Sinopsis', 20,
                                FontWeight.bold, TextAlign.left),
                            itemDetallesPelicula(
                                15,
                                8,
                                15,
                                0,
                                '${snapshot.data!.overview}',
                                15,
                                FontWeight.normal,
                                TextAlign.justify),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                btnAgregarResena(
                                    snapshot.data!.id.toString(),
                                    snapshot.data!.backdropPath,
                                    snapshot.data!.title),
                                btnVerResena(snapshot.data!.id.toString(),
                                    snapshot.data!.title),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }));
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar las peliculas.'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black54,
                backgroundColor: Colors.white,
                strokeWidth: 5.0,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget btnVerResena(String? id, String? titulo) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'verResena', arguments: {
            'id_pelicula': id,
            'titulo': titulo,
          });
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Color(0xFFffc107).withOpacity(0.9).withBlue(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Ver reseña',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget btnAgregarResena(
    String? id,
    String? backdropPath,
    String? titulo,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'agregarResena', arguments: {
            'id_pelicula': id,
            'backdropPath': backdropPath,
            'titulo': titulo
          });
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Color(0xFFffc107).withOpacity(0.9).withBlue(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Agregar reseña',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget listadoGeneroPelicula(Size size, AsyncSnapshot<Welcome> snapshot) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01, vertical: size.height * 0.01),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.genres?.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFFFFC107).withOpacity(0.9).withBlue(60),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '${snapshot.data!.genres![index].name}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemDetallesPelicula(
      double izquierda,
      double arriba,
      double derecha,
      double abajo,
      String texto,
      double tamanoTexto,
      FontWeight tipoLetra,
      TextAlign alineacion) {
    return Padding(
      padding: EdgeInsets.only(
          left: izquierda, top: arriba, right: derecha, bottom: abajo),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          textAlign: alineacion,
          texto,
          style: TextStyle(
            color: Colors.white,
            fontSize: tamanoTexto,
            fontWeight: tipoLetra,
          ),
        ),
      ),
    );
  }
}
