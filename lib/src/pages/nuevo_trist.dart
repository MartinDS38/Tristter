import 'package:flutter/material.dart';
import 'package:tristter/src/components/crear_trist.dart';

class NuevoTrist extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  NuevoTrist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Trist'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: CrearTrist(controller: _textEditingController),
      ),
    );
  }
}
