import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:ecuafilms/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class Perfil {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Usuario> obtenerUsuario(userId) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('usuarios').doc(userId.toString()).get();
      if (snapshot.exists) {
        return Usuario(
          firebaseId: snapshot.id,
          nombres: snapshot.get('nombres'),
          apellidos: snapshot.get('apellidos'),
        );
      } else {
        return Usuario(firebaseId: '', nombres: '', apellidos: '');
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
      return Usuario(firebaseId: '', nombres: '', apellidos: '');
    }
  }

  Future<Usuario> actualizarUsuario(userId, nombres, apellidos, context) async {
    try {
      await firestore.collection('usuarios').doc(userId).update({
        'nombres': nombres,
        'apellidos': apellidos,
      });
      Flushbar(
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        message: 'Datos actualizados correctamente.',
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xFF198754),
      ).show(context);
      return Usuario(
        firebaseId: userId,
        nombres: nombres,
        apellidos: apellidos,
      );
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
      Flushbar(
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        message: 'Error al actualizar el perfil, intentalo de nuevo.',
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xFFDC3545),
      ).show(context);
      return Usuario(firebaseId: '', nombres: '', apellidos: '');
    }
  }

  String imagenHash(String correo) {
    correo = correo.trim();
    correo = correo.toLowerCase();
    String hash = md5.convert(utf8.encode(correo)).toString();
    return hash;
  }
}
