import 'package:ecuafilms/controllers/api_controller.dart';
import 'package:http/http.dart' as http;
import 'package:ecuafilms/models/pelicula.dart';

class ApiPelicula {
  Future<Pelicula> get obtenerPeliculas async {
    final response = await http.get(Uri.parse(
        '${Api.baseUrl}movie/now_playing?api_key=${Api.apiKey}&language=es-ES&page=1'));

    if (response.statusCode == 200) {
      return peliculaFromJson(response.body);
    } else {
      throw Exception('Error al cargar las peliculas.');
    }
  }
  
}
