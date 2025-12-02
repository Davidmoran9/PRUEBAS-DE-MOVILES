import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TipografiaApp {
  // Títulos de películas
  static const TextStyle tituloFilm = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColoresApp.textoPrincipal,
  );

  // Director y año
  static const TextStyle directorFilm = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColoresApp.primario,
  );

  // Descripción
  static const TextStyle descripcionFilm = TextStyle(
    fontSize: 12,
    color: ColoresApp.textoSecundario,
    height: 1.3,
  );

  // Score
  static const TextStyle scoreFilm = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColoresApp.secundario,
  );

  // Año de lanzamiento
  static const TextStyle anioFilm = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ColoresApp.textoSecundario,
  );

  // Texto para AppBar
  static const TextStyle tituloAppBar = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColoresApp.textoClaro,
  );
}