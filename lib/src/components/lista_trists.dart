import 'package:flutter/material.dart';
import 'package:tristter/src/components/trist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'video_player.dart';

final tristsRef = FirebaseFirestore.instance
    .collection('trists')
    .withConverter<Trist>(
        fromFirestore: (snapshots, _) => Trist.fromJson(snapshots.data()!),
        toFirestore: (Trist, _) => Trist.toJson());

class ListaTrists extends StatefulWidget {
  const ListaTrists({super.key});

  @override
  State<ListaTrists> createState() => _ListaTristsState();
}

class _ListaTristsState extends State<ListaTrists> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Trist>>(
      stream: tristsRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            return _TristItem(
              //Index es el numero del documento en la db
              data.docs[index].data(),
              data.docs[index].reference,
            );
          },
        );
      },
    );
  }
}

class _TristItem extends StatefulWidget {
  final Trist trist;
  final DocumentReference<Trist> reference;

  _TristItem(this.trist, this.reference);

  @override
  _TristItemState createState() => _TristItemState();
}

class _TristItemState extends State<_TristItem> {
  int estrellas = 0;
  double promedio = 0;
  bool isRated = false; // Indica si se ha calificado el mensaje

  int cantidadValoraciones = 0;

  @override
  void initState() {
    super.initState();
    cantidadValoraciones = widget.trist.cantidadValoraciones;
    promedio = widget.trist.promedioEstrellas.toDouble();
  }

  Widget get autor {
    return Text(
      widget.trist.autor,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget get mensaje {
    return Text(widget.trist.mensaje);
  }

  Widget get fecha {
    return Text(
      'Enviado el ${widget.trist.fecha}',
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget get imagen {
    return Image.network(widget.trist.urlImagen!);
  }

  Widget get video {
    return VideoPlayerWidget(videoUrl: widget.trist.urlVideo!);
  }

  Widget get promedioEstrellas {
    if (cantidadValoraciones != 0) {
      promedio = (promedio * (cantidadValoraciones - 1) + estrellas) /
          cantidadValoraciones;
    }
    String promedioRedondeado = promedio.toStringAsFixed(1);
    return Text('Valoración promedio: $promedioRedondeado');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              autor,
              const SizedBox(height: 8),
              mensaje,
              const SizedBox(height: 8),
              if (widget.trist.urlImagen != "") // Mostrar imagen si existe
                imagen,
              if (widget.trist.urlVideo != "") // Mostrar video si existe
                video,
              const SizedBox(height: 8),
              fecha,
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  const Text('Puntuar: '),
                  Row(
                    children: List.generate(5, (index) {
                      final starValue = index + 1;
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: estrellas >= starValue
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            estrellas = starValue;
                            cantidadValoraciones++;
                            isRated ? null : (isRated = true);
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              promedioEstrellas,
            ],
          ),
        ),
      ),
    );
  }
}
