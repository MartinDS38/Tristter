import 'package:flutter/material.dart';

class BotonEnviar extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonEnviar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      child: const Text('Enviar'),
    );
  }
}

class BotonAdjuntarFoto extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonAdjuntarFoto({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: const CircleBorder(), // Hace que el botón sea redondo
        padding: const EdgeInsets.all(16.0),
      ),
      child: const Icon(Icons.photo), // Icono para adjuntar una foto
    );
  }
}

class BotonAdjuntarVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonAdjuntarVideo({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: const CircleBorder(), // Hace que el botón sea redondo
        padding: const EdgeInsets.all(16.0),
      ),
      child: const Icon(Icons.videocam), // Icono para adjuntar un video
    );
  }
}

class BotonCrearTrist extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonCrearTrist({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.orange,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}
