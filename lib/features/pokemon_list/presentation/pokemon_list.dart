import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon_repository.dart';
import 'package:my_pokemon_dex/features/pokemon_list/domain/get_pokemon_list_usecase.dart';
import 'pokemon_card.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late final GetPokemonListUseCase _getPokemonListUseCase;

  List<Pokemon> pokemonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    final repository = PokemonRepositoryImpl(dio);
    _getPokemonListUseCase = GetPokemonListUseCase(repository);
    _loadData();
  }

  void _loadData() async {
    try {
      final data = await _getPokemonListUseCase.execute();
      if (mounted) {
        setState(() {
          pokemonList = data;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading pokemon: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.catching_pokemon, color: Colors.red),
            SizedBox(width: 8),
            Text('Pokedex', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  return PokemonCard(
                    pokemon: pokemonList[index],
                    onTap: (pokemon) {
                      context.push('/detail', extra: pokemon);
                    },
                  );
                },
              ),
    );
  }
}
