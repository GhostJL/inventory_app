import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'dart:typed_data';
import 'package:flutter/services.dart';

class PdfGenerator {
  static Future<void> generatePDF() async {
    List<Map<String, dynamic>> products = await fetchDataProdsForPDF();

    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    String formattedTime = "${now.hour}:${now.minute}:${now.second}";

    Directory? downloadsDirectory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    downloadsDirectory ??= Directory('Downloads');

    List<List<String>> tableData =
        await Future.wait(products.map((product) async {
      String categoryName = await getCategoryName(product['category_id']);
      return [
        product['serialNumber'].toString(),
        product['name'],
        categoryName,
        product['quantity'].toString(),
        product['price'].toString(),
      ];
    }));

    Uint8List logoImage =
        (await rootBundle.load('assets/logo.jpeg')).buffer.asUint8List();

    pw.Image logoPdfImage = pw.Image(
      pw.MemoryImage(logoImage),
      width: 150,
      height: 150,
    );
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Column(
              children: [
                pw.Text('Informe de Productos',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Fecha: $formattedDate'),
                pw.Text('Hora: $formattedTime'),
                logoPdfImage,
              ],
            ),
          ),

          // Datos de la tabla
          pw.Table.fromTextArray(
            context: context,
            cellAlignment: pw.Alignment.centerLeft,
            headerAlignment: pw.Alignment.centerLeft,
            data: <List<String>>[
              [
                'Numero serial',
                'Nombre del producto',
                'Categoria',
                'Cantidad',
                'Precio'
              ],
              // Datos de la tabla
              ...tableData,
            ],
          ),
        ],
      ),
    );

    final File file = File('${downloadsDirectory.path}/informe_productos.pdf');
    await file.writeAsBytes(await pdf.save());

    showDownloadSuccess(file.path);
  }

  static Future<String> getCategoryName(int categoryId) async {
    String? category = await MyData.instance.getCategoryName(categoryId);

    return category ?? 'Sin categoría';
  }

  static Future<List<Map<String, dynamic>>> fetchDataProdsForPDF() async {
    await Future.delayed(Duration(milliseconds: 300));
    final data = await MyData.instance.getAllItemsProds();
    return data.map((product) => product.toMap()).toList();
  }

  static void showDownloadSuccess(String filePath) {
    Fluttertoast.showToast(
      msg: "Informe descargado correctamente",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );

    OpenFile.open(filePath);
  }
}
