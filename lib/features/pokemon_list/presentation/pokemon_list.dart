import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pokemon_dex/core/di/pokemon_pagination_provider.dart';
import 'pokemon_card.dart';

class PokemonList extends ConsumerStatefulWidget {
  const PokemonList({super.key});

  @override
  ConsumerState<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends ConsumerState<PokemonList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(pokemonPaginationProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonAsync = ref.watch(pokemonPaginationProvider);

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
            controller: _scrollController,
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
