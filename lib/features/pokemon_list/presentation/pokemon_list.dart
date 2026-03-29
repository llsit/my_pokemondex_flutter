import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pokemon_dex/core/di/pokemon_provider.dart';
import 'pokemon_card.dart';

class PokemonList extends ConsumerWidget {
  const PokemonList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonListProvider);

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
      body: pokemonAsync.when(
        data: (pokemonList) {
          return GridView.builder(
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
          );
        },
        error: (e, stack) => Center(child: Text("Error: $e")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
