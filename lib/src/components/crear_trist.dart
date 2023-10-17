import 'package:flutter/material.dart';
import 'dart:io';
import 'area_texto.dart';
import 'botones.dart';
import 'miniatura_imagen.dart';
import 'miniatura_video.dart';
import 'package:image_picker/image_picker.dart';
import 'trist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrearTrist extends StatefulWidget {
  final TextEditingController controller;

  const CrearTrist({super.key, required this.controller});

  @override
  _CrearTrist createState() => _CrearTrist();
}

class _CrearTrist extends State<CrearTrist> {
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  bool _hasFoto = false, _hasVideo = false;
  File? _selectedImage;
  File? _selectedVideo;

  Future<void> _adjuntarFoto() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _hasFoto = true;
          _selectedImage = File(pickedImage.path);
          _selectedVideo = null;
          _hasVideo = false;
        });
      }
    } catch (e) {
      print("Error al adjuntar foto: $e");
    }
  }

  Future<void> _adjuntarVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      setState(() {
        _hasVideo = true;
        _selectedVideo = File(pickedVideo.path);
        _selectedImage = null;
        _hasFoto = false;
      });
    }
  }

  Future<String> subirArchivo(File file, String folderName) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(DateTime.now().toString());

    final UploadTask uploadTask = storageReference.putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask;

    if (taskSnapshot.state == TaskState.success) {
      final String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      return ""; // Ocurrió un error al subir el archivo
    }
  }

  Future<void> _enviarMensaje() async {
    final autor = _autorController.text;
    final mensaje = _textEditingController.text;
    final fecha = DateFormat('dd/MM/yyyy HH:mm')
        .format(DateTime.parse(DateTime.now().toString()));

    final trist = Trist(
      autor: autor,
      mensaje: mensaje,
      fecha: fecha,
      urlImagen: "",
      urlVideo: "",
      promedioEstrellas: 0,
      cantidadValoraciones: 0,
    );

    if (_hasFoto) {
      trist.urlImagen = await subirArchivo(_selectedImage!, "imagenes");
    }

    if (_hasVideo) {
      trist.urlVideo = await subirArchivo(_selectedVideo!, "videos");
    }

    try {
      final tristsRef = FirebaseFirestore.instance.collection('trists');

      await tristsRef
          .add(trist.toJson()); // Agrega el objeto JSON a la colección 'trists'
      print('Trist agregado correctamente a Firebase');
    } catch (e) {
      print('Error al agregar el Trist a Firebase: $e');
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 400, // Ancho del componente de forma de caja
      //height: alto, // Altura del componente de forma de caja
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.orange, // Color del borde de la caja
          width: 2.0, // Ancho del borde de la caja
        ),
        borderRadius:
            BorderRadius.circular(10.0), // Radio de la esquina de la caja
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _autorController,
                  decoration: const InputDecoration(labelText: 'Autor'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AreaTexto(
                      controller: _textEditingController,
                      hasFoto: _hasFoto,
                      hasVideo: _hasVideo,
                    ),
                  ),
                ),
                if (_selectedImage != null)
                  MiniaturaImagen(
                    mediaFile: _selectedImage,
                    onDelete: () {
                      setState(() {
                        _selectedImage = null;
                        _hasFoto = false;
                      });
                    },
                  ),
                if (_selectedVideo != null)
                  MiniaturaVideo(
                    videoFile: _selectedVideo!,
                    onDelete: () {
                      setState(() {
                        _selectedVideo = null;
                        _hasVideo = false;
                      });
                    },
                  ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      BotonAdjuntarFoto(onPressed: _adjuntarFoto),
                      BotonAdjuntarVideo(onPressed: _adjuntarVideo),
                    ],
                  ),
                ),
                Align(
                  alignment:
                      Alignment.centerRight, // Alinea el botón a la derecha
                  child: BotonEnviar(
                    onPressed: () {
                      _enviarMensaje();
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
