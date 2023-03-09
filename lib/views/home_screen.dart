import 'package:ecuafilms/controllers/pelicula_controller.dart';
import 'package:ecuafilms/api/api.dart';
import 'package:ecuafilms/widgets/menu_pelicula_screen.dart';
import '../models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

const image = Api.imageBaseUrl;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Home createState() => _Home();
}

Future<Pelicula> detallePelicula = PeliculaController().obtenerPeliculas;

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF242A32),
        actions: const <Widget>[],
      ),
      drawer: const MenuPelicula(),
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
        child: FutureBuilder<Pelicula>(
          future: detallePelicula,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.only(top: 15),
                children: [
                  caruselPelicula(snapshot),
                  espacio(10),
                  _titulo('Peliculas', 20),
                  _lista_peliculas(snapshot),
                ],
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black54,
                backgroundColor: Colors.white,
                strokeWidth: 5.0,
              ));
            }
          },
        ),
      ),
    );
  }

  SizedBox espacio(double espacio) => SizedBox(height: espacio);

  Padding _titulo(String titulo, double size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        titulo,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding _lista_peliculas(AsyncSnapshot<Pelicula> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: snapshot.data!.results!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(3),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'detalle_pelicula',
                      arguments: snapshot.data!.results![index].id);
                  // ignore: avoid_print
                  print(snapshot.data!.results![index].id);
                },
                child: Column(
                  children: [
                    Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${image}w500${snapshot.data!.results![index].posterPath}',
                        fit: BoxFit.fill,
                      ),
                    )),
                  ],
                )),
          );
        },
      ),
    );
  }

  CarouselSlider caruselPelicula(AsyncSnapshot<Pelicula> snapshot) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 280.00,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        viewportFraction: 0.5,
        scrollDirection: Axis.horizontal,
      ),
      items: snapshot.data!.results!
          .map(
            (item) => Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '${image}w500${item.posterPath}',
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
