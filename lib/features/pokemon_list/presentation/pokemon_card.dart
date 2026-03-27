import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonCard extends StatelessWidget {
  final Map<String, dynamic> pokemon;
  final Function(String) onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      color: pokemon['backgroundColor'],
      child: InkWell(
        onTap: () => onTap(pokemon['name']),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .05),
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.all(8),
                    ),
                    Hero(
                      tag: 'pokemon-image-${pokemon['name']}',
                      child: CachedNetworkImage(
                        imageUrl: pokemon['imageUrl'],
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder:
                            (context, url) => const CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '#${pokemon['id']}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withValues(alpha: .6),
                ),
              ),
              Text(
                pokemon['name'],
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
