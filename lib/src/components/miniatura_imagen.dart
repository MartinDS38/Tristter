import 'package:flutter/material.dart';
import 'dart:io';

class MiniaturaImagen extends StatelessWidget {
  final File? mediaFile;
  final VoidCallback onDelete;

  const MiniaturaImagen({super.key, 
    required this.mediaFile,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130, // Ancho deseado para la miniatura
      height: 130, // Alto deseado para la miniatura
      child: Stack(
        children: [
          if (mediaFile != null)
            Image.file(
              mediaFile!,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
          Positioned(
            top: 0,
            left: 80,
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
