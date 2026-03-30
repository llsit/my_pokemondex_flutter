import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_dex/core/data/pokemon_repository.dart';
import 'package:my_pokemon_dex/features/pokemon_detail/data/pokemon_detail_model.dart';
import 'package:my_pokemon_dex/features/pokemon_detail/domain/get_pokemon_detail_usecase.dart';
import 'package:my_pokemon_dex/features/pokemon_list/domain/get_pokemon_list_usecase.dart';

final dioProvider = Provider((ref) => Dio());

final repositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(ref.watch(dioProvider));
});

final getPokemonListUseCaseProvider = Provider((ref) {
  return GetPokemonListUseCase(ref.watch(repositoryProvider));
});

final getPokemonDetailUseCaseProvider = Provider((ref) {
  return GetPokemonDetailUseCase(ref.watch(repositoryProvider));
});

final pokemonDetailProvider = FutureProvider.family<PokemonDetailModel, String>(
  (ref, name) async {
    return ref.watch(getPokemonDetailUseCaseProvider).execute(name);
  },
);
