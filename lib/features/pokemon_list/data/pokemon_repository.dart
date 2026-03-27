import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList(int limit, int offset);
}

class PokemonRepositoryImpl implements PokemonRepository {
  final Dio dio;

  PokemonRepositoryImpl(this.dio);

  static const String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  @override
  Future<List<Pokemon>> getPokemonList(int limit, int offset) async {
    final response = await dio.get(
      baseUrl,
      queryParameters: {"limit": limit, "offset": offset},
    );

    final results = response.data['results'] as List;

    final List<Pokemon> list =
        results.map((pokemon) {
          final url = pokemon['url'] as String;
          final id = url.split('/').where((e) => e.isNotEmpty).last;

          return Pokemon(
            id: "#${id.padLeft(4, '0')}",
            name: _capitalize(pokemon['name']),
            imageUrl:
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png",
            backgroundColor: Colors.grey.withValues(alpha: .2),
          );
        }).toList();

    return list;
  }

  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
