class Usuario {
  String? nombres;
  String? apellidos;
  String? correo;
  String? firebaseId;
  Usuario({this.nombres, this.apellidos, this.correo, this.firebaseId});

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'correo': correo,
      'firebaseId': firebaseId,
    };
  }
}
