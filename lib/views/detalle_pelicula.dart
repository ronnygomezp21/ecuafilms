import 'package:ecuafilms/controllers/api_controller.dart';
import 'package:ecuafilms/controllers/pelicula_controller.dart';
import 'package:ecuafilms/models/detalle_pelicula.dart';

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
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    Future<Welcome> detallePelicula =
        ApiPelicula().obtenerDetallePelicula(args);

    return Scaffold(
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
                        return Column(children: [
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
                                          '${image}w500${snapshot.data!.backdropPath}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SafeArea(
                                    child: Container(
                                  alignment: Alignment.topLeft,
                                  child: const BackButton(
                                    color: Colors.white,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                '${snapshot.data!.title}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Container(
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01,
                                vertical: size.height * 0.02),
                            child: SizedBox(
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.genres?.length,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${snapshot.data!.genres![index].name}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                'Sinopsis',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15, bottom: 15),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                textAlign: TextAlign.justify,
                                '${snapshot.data!.overview}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }));
            } else if (snapshot.hasError) {
              return const Text('Error al cargar los datos');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
