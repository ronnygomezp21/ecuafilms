import 'package:ecuafilms/views/detalle_pelicula.dart';
import 'package:ecuafilms/views/home.dart';
import 'package:ecuafilms/views/perfi_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    name: 'ecuafilms-94918',
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
        scaffoldBackgroundColor: const Color(0xFF242A32),
        primaryColor: const Color(0xFF242A32),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF242A32),
        ),
      ),
      title: 'Login',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const Home();
          } else if (snapshot.hasError) {
            return const Center(
              child: AlertDialog(
                title: Text('Error'),
                content: Text('algo salió mal, intentalo mas tarde.'),
                icon: Icon(Icons.error),
                iconColor: Colors.red,
              ),
            );
          } else {
            return const Login();
          }
        },
      ),
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
