import 'package:flutter/material.dart';

class AreaTexto extends StatefulWidget {
  final TextEditingController controller;
  final bool hasFoto, hasVideo;

  const AreaTexto(
      {super.key,
      required this.controller,
      required this.hasFoto,
      required this.hasVideo});

  @override
  _AreaTexto createState() => _AreaTexto();
}

class _AreaTexto extends State<AreaTexto> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: (widget.hasFoto || widget.hasVideo)
          ? 3
          : 7, // Permite múltiples líneas de texto
      maxLength: (widget.hasFoto || widget.hasVideo)
          ? 100
          : 250, // Establece la longitud máxima
      decoration: const InputDecoration(
          //labelText: 'Nuevo Trist',
          //counterText: '', // Oculta el contador de caracteres
          ),
    );
  }
}
