import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Función para guardar una imagen y devolver la ruta
Future<String> saveImage(File imageFile) async {
  try {
    // Obtiene el directorio de documentos
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    // Genera un nombre único para la imagen (puedes usar otro método según tus necesidades)
    String imageName = 'image_${DateTime.now().millisecondsSinceEpoch}.png';

    // Construye la ruta completa del archivo
    String imagePath = '${appDocumentsDirectory.path}/$imageName';

    // Copia el archivo al directorio de documentos
    await imageFile.copy(imagePath);

    // Devuelve la ruta completa del archivo
    return imagePath;
  } catch (error) {
    print('Error al guardar la imagen: $error');
    return ''; // Devuelve una cadena vacía en caso de error
  }
}
