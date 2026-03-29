import 'package:my_pokemon_dex/core/data/pokemon_repository.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';

class GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCase(this.repository);

  Future<List<Pokemon>> execute(int limit, int offset) async {
    final list = await repository.getPokemonList(limit, offset);
    list.sort((a, b) {
      final int idA = int.parse(a.id.replaceAll('#', ''));
      final int idB = int.parse(b.id.replaceAll('#', ''));
      return idA.compareTo(idB);
    });
    return list;
  }
}
