import 'package:my_pokemon_dex/core/data/pokemon_repository.dart';
import 'package:my_pokemon_dex/features/pokemon_detail/data/pokemon_detail_model.dart';

class GetPokemonDetailUseCase {
  final PokemonRepository repository;

  GetPokemonDetailUseCase(this.repository);

  Future<PokemonDetailModel> execute(String name) async {
    return await repository.getPokemonDetail(name);
  }
}
