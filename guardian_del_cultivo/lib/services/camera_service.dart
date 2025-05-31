import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  // Método para tomar foto con la cámara
  Future<File?> tomarFoto() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // 🔹 Método para seleccionar imagen desde la galería
  Future<File?> seleccionarImagen() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Método para enviar imagen al backend
  Future<String?> enviarImagenAlBackend(File imagen) async {
    final uri = Uri.parse('http://192.168.1.142:5000/predict');

    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imagen.path));

    try {
      final response = await request.send();
      final respuesta = await http.Response.fromStream(response);

      if (respuesta.statusCode == 200) {
        final data = jsonDecode(respuesta.body);
        return data['resultado']; 
      } else {
        print('Error en el backend: ${respuesta.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al enviar la imagen: $e');
      return null;
    }
  }
}