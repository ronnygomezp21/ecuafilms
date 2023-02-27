import 'dart:convert';

Pelicula peliculaFromJson(String str) => Pelicula.fromJson(json.decode(str));

String peliculaToJson(Pelicula data) => json.encode(data.toJson());

class Pelicula {
  Pelicula({
    this.page,
    this.results,
  });

  final int? page;
  final List<Result>? results;

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.adult,
    this.id,
    this.posterPath,
    this.releaseDate,
    this.title,
  });

  final bool? adult;
  final int? id;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        id: json["id"],
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "id": id,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "title": title,
      };
}
