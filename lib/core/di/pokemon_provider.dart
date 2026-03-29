import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_dex/core/data/pokemon_repository.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';
import 'package:my_pokemon_dex/features/pokemon_list/domain/get_pokemon_list_usecase.dart';

final dioProvider = Provider((ref) => Dio());

final repositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(ref.watch(dioProvider));
});

final getPokemonListUseCaseProvider = Provider((ref) {
  return GetPokemonListUseCase(ref.watch(repositoryProvider));
});

final pokemonListProvider = FutureProvider<List<Pokemon>>((ref) async {
  return ref.watch(getPokemonListUseCaseProvider).execute();
});
