import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_dex/core/di/pokemon_provider.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';

class PokemonPaginationNotifier extends AsyncNotifier<List<Pokemon>> {
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;
  bool isLoadingMore = false;

  @override
  Future<List<Pokemon>> build() async {
    return _fetchPokemons();
  }

  Future<List<Pokemon>> _fetchPokemons() async {
    final useCase = ref.read(getPokemonListUseCaseProvider);
    final newList = await useCase.execute(limit, offset);

    if (newList.isEmpty) {
      hasMore = false;
    } else {
      offset += limit;
    }

    return [...(state.value ?? []), ...newList];
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _fetchPokemons();
    });

    isLoadingMore = false;
  }
}

final pokemonPaginationProvider =
    AsyncNotifierProvider<PokemonPaginationNotifier, List<Pokemon>>(
      PokemonPaginationNotifier.new,
    );
