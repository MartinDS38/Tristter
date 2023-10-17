import 'package:flutter/material.dart';
import '/src/pages/home_page.dart';

// Los widgets son clases comunes y corrientes que extienden de determinada clase según el tipo de widget que deseamos crear.
// En este caso MyApp extiende de StatelessWidget
// StatelessWidget nos permite crear un widget que no almacena estado osea estático
class MyApp extends StatelessWidget {
  const MyApp({super.key});

// Como es una clase abstracta tiene un método que necesariamente debe ser sobreescrito, este es el método 'build'.
// Este método recibe como parametro un contexto.
// Este contexto es dado por runApp para que el build haga uso de él al crear el widget.
// Dentro de build es donde diseñaremos nuestro widget y este lo retornaremos.
  @override
  Widget build(BuildContext context) {
    //MaterialApp es el widget padre que proporciona el diseño de material dentro de la aplicación.
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
