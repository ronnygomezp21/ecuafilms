import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecuafilms/main.dart';
import 'package:ecuafilms/models/usuario_model.dart';
import 'package:ecuafilms/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sesion {
  Future login(String email, String password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim().toString(),
              password: password.trim().toString())
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Flushbar(
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          message: 'correo o contraseña incorrectos.',
          duration: const Duration(seconds: 3),
          backgroundColor: const Color(0xFFDC3545),
        ).show(context);
      }
    }
  }

  Future registrarseFireBase(String nombres, String apellidos, String email,
      String password, context) async {
    try {
      UserCredential resultado =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      Usuario usuario = Usuario(
        nombres: nombres.trim(),
        apellidos: apellidos.trim(),
        correo: email.trim(),
        firebaseId: resultado.user?.uid,
      );
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(resultado.user?.uid)
          .set(usuario.toJson())
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyApp())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Flushbar(
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          message: 'El correo ya esta en uso.',
          duration: const Duration(seconds: 3),
          backgroundColor: const Color(0xFFDC3545),
        ).show(context);
      } else {
        Flushbar(
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          message: 'Error al registrarse, intentalo de nuevo.',
          duration: const Duration(seconds: 3),
          backgroundColor: const Color(0xFFDC3545),
        ).show(context);
      }
    }
  }
}
