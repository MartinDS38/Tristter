import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import 'dart:typed_data';

class MiniaturaVideo extends StatelessWidget {
  final File videoFile;
  final VoidCallback onDelete;

  const MiniaturaVideo({super.key, required this.videoFile, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 130, // Ancho deseado para la miniatura
      //height: 130, // Alto deseado para la miniatura
      child: Stack(
        children: [
          FutureBuilder<Uint8List?>(
            future: VideoThumbnail.thumbnailData(
              video: videoFile.path,
              imageFormat: ImageFormat.JPEG,
              //maxWidth: 130,
              //maxHeight: 130, // Altura deseada para la miniatura
              quality: 25, // Calidad de la miniatura
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Image.memory(snapshot.data!);
              } else if (snapshot.hasError) {
                return const Text('Error al generar la miniatura');
              } else {
                return const CircularProgressIndicator(); // Indicador de carga
              }
            },
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.red,
              ),
              onPressed: onDelete,
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
