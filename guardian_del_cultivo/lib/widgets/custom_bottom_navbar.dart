import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final VoidCallback? onCapture;
  final VoidCallback? onSelectImage;

  const CustomBottomNavbar({
    super.key,
    this.onCapture,
    this.onSelectImage,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.green[700],
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: onCapture ?? () {},
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              label: const Text('Capturar Foto', style: TextStyle(color: Colors.white)),
            ),
            TextButton.icon(
              onPressed: onSelectImage ?? () {},
              icon: const Icon(Icons.photo, color: Colors.white),
              label: const Text('Subir Foto', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}