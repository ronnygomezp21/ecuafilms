import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecuafilms/api/api.dart';
import 'package:ecuafilms/models/resena_model.dart';
import 'package:ecuafilms/views/detalle_pelicula_screen.dart';
import 'package:ecuafilms/views/home_screen.dart';
import 'package:flutter/material.dart';

class AgregarResenaPeliculaScreen extends StatefulWidget {
  const AgregarResenaPeliculaScreen({super.key});

  @override
  State<AgregarResenaPeliculaScreen> createState() =>
      _AgregarResenaPeliculaScreenState();
}

class _AgregarResenaPeliculaScreenState
    extends State<AgregarResenaPeliculaScreen> {
  final _formKey = GlobalKey<FormState>();
  final txtresena = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? argumentos = ModalRoute.of(context)?.settings.arguments as Map?;
    const rutaImagen = Api.imageBaseUrl;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/fondo_1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(argumentos!['titulo'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        '${rutaImagen}original${argumentos['backdropPath']}',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      minLines: 1,
                      controller: txtresena,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: const Color.fromARGB(137, 255, 255, 255),
                          hintText: 'Deja tu reseña',
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.menu, color: Colors.black),
                          contentPadding: const EdgeInsets.only(top: 14.0)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'La reseña no puede estar vacia';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: Color(0xFFffc107)
                                    .withOpacity(0.8)
                                    .withBlue(60),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  agregarResena(argumentos['id_pelicula'],
                                      txtresena.text);
                                }
                              },
                              child: const Text('Guardar',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: const Color(0xFFffc107)
                                    .withOpacity(0.8)
                                    .withBlue(60),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                              child: const Text('Cancelar',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                            ),
                          )
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future agregarResena(String id, String texto) async {
    final CollectionReference resenas =
        FirebaseFirestore.instance.collection('reseñas');

    Resena resena = Resena(
      idPelicula: id,
      descripcion: texto,
    );

    try {
      await resenas.add(resena.toJson());
      SnackBar snackBar = const SnackBar(
        content: Text('Reseña agregada con exito.'),
        backgroundColor: Colors.green,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } catch (e) {}
  }
}
