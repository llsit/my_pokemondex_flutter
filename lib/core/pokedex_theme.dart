import 'package:flutter/material.dart';

class PokedexTheme {
  static const slate950 = Color(0xFF020617);
  static const slate900 = Color(0xFF0F172A);
  static const slate400 = Color(0xFF94A3B8);
  static const orange600 = Color(0xFFEA580C);

  static Color getTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'grass':
        return const Color(0xFF48D0B0);
      case 'fire':
        return const Color(0xFFFB6C6C);
      case 'water':
        return const Color(0xFF77BDFE);
      case 'electric':
        return const Color(0xFFFFD76F);
      case 'poison':
        return const Color(0xFFA040A0);
      default:
        return const Color(0xFF94A3B8);
    }
  }
}
