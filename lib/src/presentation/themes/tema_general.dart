import 'package:flutter/material.dart';
import 'esquema_color.dart';

final ThemeData temaGeneral = ThemeData(
  primarySwatch: Colors.green,
  primaryColor: ColoresApp.primario,
  scaffoldBackgroundColor: ColoresApp.fondo,
  fontFamily: 'Roboto',
  
  appBarTheme: const AppBarTheme(
    backgroundColor: ColoresApp.primario,
    elevation: 3,
    centerTitle: true,
    foregroundColor: ColoresApp.textoClaro,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: ColoresApp.textoClaro,
    ),
  ),
  
  cardTheme: CardThemeData(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: ColoresApp.fondoTarjeta,
    shadowColor: ColoresApp.sombra,
  ),
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColoresApp.botonPrincipal,
      foregroundColor: ColoresApp.textoClaro,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: ColoresApp.textoPrincipal,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: ColoresApp.textoPrincipal,
    ),
    bodyMedium: TextStyle(
      color: ColoresApp.textoSecundario,
    ),
  ),
  
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColoresApp.primario,
    brightness: Brightness.light,
  ),
);