import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_pokemon_dex/features/pokemon_detail/data/pokemon_detail_model.dart';
import 'package:my_pokemon_dex/features/pokemon_detail/presentation/pokemon_detail.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList(int limit, int offset);

  Future<PokemonDetailModel> getPokemonDetail(String name);
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

  @override
  Future<PokemonDetailModel> getPokemonDetail(String name) async {
    final response = await dio.get("$baseUrl/$name");
    final data = response.data;

    final id = data['id'].toString();

    final heightInMeters = (data['height'] as int) / 10;

    final weightInKg = (data['weight'] as int) / 10;

    final imageUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";

    final types =
        (data['types'] as List)
            .map((t) => (t['type']['name'] as String).toUpperCase())
            .toList();

    final abilities =
        (data['abilities'] as List)
            .map((a) => (a['ability']['name'] as String).toUpperCase())
            .toList();

    final stats = data['stats'] as List;

    int getStat(String statName) {
      return stats.firstWhere(
        (s) => s['stat']['name'] == statName,
      )['base_stat'];
    }

    return PokemonDetailModel(
      id: "#${id.padLeft(4, '0')}",
      name: _capitalize(data['name']),
      heightInMeters: heightInMeters.toDouble(),
      weightInKg: weightInKg.toDouble(),
      imageUrl: imageUrl,
      types: types,
      abilities: abilities,
      hp: getStat('hp'),
      attack: getStat('attack'),
      defense: getStat('defense'),
      specialAttack: getStat('special-attack'),
      specialDefense: getStat('special-defense'),
      speed: getStat('speed'),
    );
  }
}
