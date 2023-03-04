class Usuario {
  String? nombres;
  String? apellidos;
  String? correo;
  String? firebaseId;
  Usuario({this.nombres, this.apellidos, this.correo, this.firebaseId});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      correo: json['correo'],
      firebaseId: json['firebaseId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'correo': correo,
      'firebaseId': firebaseId,
    };
  }
}
