import 'dart:convert';

import 'package:ecuafilms/api/api.dart';
import 'package:ecuafilms/models/detalle_pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecuafilms/models/pelicula_model.dart';

class PeliculaController {
  Future<Pelicula> get obtenerPeliculas async {
    final response = await http.get(Uri.parse(
        '${Api.baseUrl}movie/now_playing?api_key=${Api.apiKey}&language=es-ES&page=1'));

    if (response.statusCode == 200) {
      return peliculaFromJson(response.body);
    } else {
      throw Exception('Error al cargar las peliculas.');
    }
  }

  Future<Welcome> obtenerDetallePelicula(Object? idPelicula) async {
    final response = await http.get(Uri.parse(
        '${Api.baseUrl}movie/$idPelicula?api_key=${Api.apiKey}&language=es-ES'));

    if (response.statusCode == 200) {
      return welcomeFromJson(response.body);
    } else {
      throw Exception('Error al cargar el detalle de la pelicula.');
    }
  }
}
