import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_pokemon_dex/core/pokedex_theme.dart';
import 'package:my_pokemon_dex/features/pokemon_list/data/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetail({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final primaryColor = PokedexTheme.getTypeColor(pokemon.name);

    return Scaffold(
      backgroundColor: PokedexTheme.slate950,
      appBar: AppBar(
        backgroundColor: PokedexTheme.slate950.withValues(alpha: .6),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'POKÉDEX',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: MediaQuery.of(context).size.width / 2 - 140,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PokedexTheme.orange600.withValues(alpha: .15),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${pokemon.id}',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pokemon.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    _TypeBadge(label: "GRASS", color: primaryColor),
                  ],
                ),
                const SizedBox(height: 20),

                Center(
                  child: Hero(
                    tag: pokemon.id,
                    child: Image.network(
                      pokemon.imageUrl,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                _BentoBox(
                  child: Column(
                    children: [
                      _LabelHeader(
                        icon: Icons.info,
                        label: "About",
                        color: primaryColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _StatMetric(label: "Weight", value: "6.9 kg"),
                          _StatMetric(label: "Height", value: "0.7 m"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _BentoBox(
                  child: Column(
                    children: [
                      _LabelHeader(
                        icon: Icons.leaderboard,
                        label: "Base Stats",
                        color: primaryColor,
                      ),
                      _StatBar(
                        label: "HP",
                        value: 45,
                        progress: 0.2,
                        color: primaryColor,
                      ),
                      _StatBar(
                        label: "ATK",
                        value: 49,
                        progress: 0.3,
                        color: primaryColor,
                      ),
                      _StatBar(
                        label: "DEF",
                        value: 49,
                        progress: 0.3,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BentoBox extends StatelessWidget {
  final Widget child;
  const _BentoBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PokedexTheme.slate900.withValues(alpha: .4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: .05)),
      ),
      child: child,
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final double progress;
  final Color color;

  const _StatBar({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: .8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              label,
              style: const TextStyle(
                color: PokedexTheme.slate400,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: PokedexTheme.slate950,
                color: color,
                minHeight: 8,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '$value',
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TypeBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: .3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _LabelHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _LabelHeader({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatMetric extends StatelessWidget {
  final String label;
  final String value;
  const _StatMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: PokedexTheme.slate400,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
