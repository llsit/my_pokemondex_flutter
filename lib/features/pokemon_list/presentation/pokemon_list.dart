import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pokemon_card.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  // mock data
  final List<Map<String, dynamic>> pokemonList = [
    {
      "id": "0001",
      "name": "Bulbasaur",
      "imageUrl":
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
      "backgroundColor": const Color(0xFF74CB48).withValues(alpha: 0.2),
    },
    {
      "id": "0004",
      "name": "Charmander",
      "imageUrl":
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
      "backgroundColor": const Color(0xFFF57D31).withValues(alpha: 0.2),
    },
    {
      "id": "0007",
      "name": "Squirtle",
      "imageUrl":
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png",
      "backgroundColor": const Color(0xFF6493EB).withValues(alpha: 0.2),
    },
    {
      "id": "0025",
      "name": "Pikachu",
      "imageUrl":
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
      "backgroundColor": const Color(0xFFF7D02C).withValues(alpha: 0.2),
    },
    {
      "id": "0012",
      "name": "Butterfree",
      "imageUrl":
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/12.png",
      "backgroundColor": const Color(0xFFA891EC).withValues(alpha: 0.2),
    },
    {
      "id": "0010",
      "name": "Caterpie",
      "imageUrl":
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10.png",
      "backgroundColor": const Color(0xFF74CB48).withValues(alpha: 0.2),
    },
  ];

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
      body: GridView.builder(
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
              print("Clicked on $pokemon");
              context.push('/detail',extra: pokemon);
            },
          );
        },
      ),
    );
  }
}
