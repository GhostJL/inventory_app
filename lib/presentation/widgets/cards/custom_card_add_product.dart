import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class CustomCardAdd extends StatefulWidget {
  final ValueChanged<String> onImageSelected;

  const CustomCardAdd({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _CustomCardAddState createState() => _CustomCardAddState();
}

class _CustomCardAddState extends State<CustomCardAdd> {
  String? imagePath;

  Future<void> _showImageSourceMenu() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Seleccionar desde la galería'),
              onTap: () async {
                await _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Tomar una nueva foto'),
              onTap: () async {
                await _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: source,
    );

    if (image != null) {
      String uniqueFileName = "${_uuid.v4()}.jpg";
      await _saveImageToPath(image.path, uniqueFileName);

      setState(() {
        imagePath = image.path;
      });
    }
  }

  Future<void> _saveImageToPath(String imagePath, String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    if (!Directory("${appDocDir.path}/Productos").existsSync()) {
      Directory("${appDocDir.path}/Productos").createSync(recursive: true);
    }

    String targetPath = "${appDocDir.path}/Productos/$fileName";

    File(imagePath).copySync(targetPath);
    widget.onImageSelected(targetPath);

    print("Imagen guardada en: $targetPath");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        color: Color(0xFFF9F9F9),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (imagePath != null)
              Image.file(
                File(imagePath!),
                fit: BoxFit.fill,
              ),
            InkWell(
              onTap: () {
                _showImageSourceMenu();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (imagePath == null)
                    Icon(
                      Icons.camera_alt,
                      size: 64.0,
                    ),
                  SizedBox(height: 10),
                  if (imagePath == null)
                    Text(
                      'Haga clic para subir o tomar una foto',
                      style: TextStyle(fontSize: 16.0),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
