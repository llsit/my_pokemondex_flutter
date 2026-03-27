import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pokemon_dex/features/pokemon_detail/presentation/pokemon_detail.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';
import './features/pokemon_list/presentation/pokemon_list.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PokemonList()),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final pokemon = state.extra as Pokemon;
        return PokemonDetail(pokemon: pokemon);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.red),
    );
  }
}
