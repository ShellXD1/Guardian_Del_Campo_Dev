import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../services/camera_service.dart';
import 'dart:io';
import 'resultado_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _abrirCamara(BuildContext context) async {
    final cameraService = CameraService();

    print('Intentando tomar foto...');
    File? foto = await cameraService.tomarFoto();

    if (foto == null) {
      print('No se tomó foto');
      return;
    }

    print('Foto tomada: ${foto.path}');
    print('Enviando imagen al backend...');

    // Navega inmediatamente y pasa el Future
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoScreen(
          resultadoFuture: cameraService.enviarImagenAlBackend(foto),
        ),
      ),
    );
  }

  void _seleccionarImagen(BuildContext context) async {
    final cameraService = CameraService();

    print('Intentando seleccionar imagen...');
    File? imagen = await cameraService.seleccionarImagen();

    if (imagen == null) {
      print('No se seleccionó ninguna imagen');
      return;
    }

    print('Imagen seleccionada: ${imagen.path}');
    print('Enviando imagen al backend...');

    // Navega inmediatamente y pasa el Future
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoScreen(
          resultadoFuture: cameraService.enviarImagenAlBackend(imagen),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavbar(title: 'Inicio'),
      bottomNavigationBar: CustomBottomNavbar(
        onCapture: () => _abrirCamara(context),
        onSelectImage: () => _seleccionarImagen(context),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenido a Guardian del Cultivo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Esta aplicación te ayuda a detectar plagas en cultivos de forma rápida y precisa ayudándote a proteger tus cultivos y su producción.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Para iniciar presiona el botón "Capturar Foto" o "Subir Foto" en la barra inferior.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
