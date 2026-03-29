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
    final useCase = ref.read(getPokemonListUseCaseProvider);
    final list = await useCase.execute(limit, offset);
    offset += limit;
    return list;
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;

    final useCase = ref.read(getPokemonListUseCaseProvider);
    final newList = await useCase.execute(limit, offset);

    if (newList.isEmpty) {
      hasMore = false;
    } else {
      offset += limit;
      state = AsyncData([...state.value ?? [], ...newList]);
    }

    isLoadingMore = false;
  }

  Future<void> refresh() async {
    offset = 0;
    hasMore = true;

    final useCase = ref.read(getPokemonListUseCaseProvider);
    final list = await useCase.execute(limit, offset);
    offset += limit;

    state = AsyncData(list);
  }
}

final pokemonPaginationProvider =
    AsyncNotifierProvider<PokemonPaginationNotifier, List<Pokemon>>(
      PokemonPaginationNotifier.new,
    );
