class Resena {
  String? idPelicula;
  String? descripcion;
  Resena({
    this.idPelicula,
    this.descripcion,
  });

  Map<String, dynamic> toJson() {
    return {
      'idPelicula': idPelicula,
      'descripcion': descripcion,
    };
  }
}
