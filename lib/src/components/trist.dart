class Trist {
  final String autor, mensaje, fecha;
  String? urlImagen, urlVideo;
  final int promedioEstrellas, cantidadValoraciones;

  Trist({
    required this.autor,
    required this.mensaje,
    required this.fecha,
    this.urlImagen,
    this.urlVideo,
    required this.promedioEstrellas,
    required this.cantidadValoraciones,
  });

  Trist.fromJson(Map<String, Object?> json)
      : this(
          autor: json['autor']! as String,
          mensaje: json['mensaje']! as String,
          fecha: json['fecha']! as String,
          urlImagen: json['imagen']! as String?,
          urlVideo: json['video']! as String?,
          promedioEstrellas: json['promedio_estrellas']! as int,
          cantidadValoraciones: json['cantidad_valoraciones']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'autor': autor,
      'mensaje': mensaje,
      'fecha': fecha,
      'imagen': urlImagen,
      'video': urlVideo,
      'promedio_estrellas': promedioEstrellas,
      'cantidad_valoraciones': cantidadValoraciones,
    };
  }
}
