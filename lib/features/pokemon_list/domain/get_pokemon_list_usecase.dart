import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';

import '../data/pokemon_repository.dart';

class GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCase(this.repository);

  Future<List<Pokemon>> execute() async {
    final list = await repository.getPokemonList(10, 0);
    list.sort((a, b) {
      final int idA = int.parse(a.id.replaceAll('#', ''));
      final int idB = int.parse(b.id.replaceAll('#', ''));
      return idA.compareTo(idB);
    });
    return list;
  }
}
