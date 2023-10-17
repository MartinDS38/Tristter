import 'package:flutter/material.dart';
import 'nuevo_trist.dart';
import 'package:tristter/src/components/botones.dart';
import 'package:tristter/src/components/lista_trists.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> nuevoTrist() async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NuevoTrist(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Tristter'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: const ListaTrists(),
      floatingActionButton: BotonCrearTrist(
        onPressed: nuevoTrist,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
