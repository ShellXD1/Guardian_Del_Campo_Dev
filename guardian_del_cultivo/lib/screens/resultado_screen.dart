import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import 'home_screen.dart';

class ResultadoScreen extends StatefulWidget {
  final Future<String?> resultadoFuture;

  const ResultadoScreen({super.key, required this.resultadoFuture});

  @override
  State<ResultadoScreen> createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> {
  String? resultado;
  bool cargando = true;
  bool error = false;

  @override
  void initState() {
    super.initState();
    widget.resultadoFuture.then((value) {
      if (value == null) {
        setState(() {
          error = true;
          cargando = false;
        });
      } else {
        setState(() {
          resultado = value;
          cargando = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavbar(title: 'Resultado'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[700],
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text(
                  'Volver al Inicio',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: cargando
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Analizando imagen...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            : error
                ? const Text(
                    'No se pudo analizar la imagen. Intenta nuevamente.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 80),
                      const SizedBox(height: 20),
                      const Text(
                        'Resultado:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        resultado ?? '',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
      ),
    );
  }
}
