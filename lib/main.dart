import 'package:ecuafilms/views/detalle_pelicula.dart';
import 'package:ecuafilms/views/home.dart';
import 'package:ecuafilms/views/perfi_usuario.dart';
import 'package:flutter/material.dart';
import 'package:ecuafilms/views/login.dart';
import 'package:ecuafilms/views/register.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

void setup() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF242A32),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF242A32),
        primaryColor: Color(0xFF242A32),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF242A32),
        ),
      ),
      title: 'Login',
      home: const Login(),
      routes: {
        'login': (BuildContext context) => const Login(),
        'register': (BuildContext context) => const Register(),
        'home': (BuildContext context) => const Home(),
        'detalle_pelicula': (BuildContext context) => const DetallePelicula(),
        'perfil_usuario': (BuildContext context) => const PerfilUsuario(),
      },
    );
  }
}
