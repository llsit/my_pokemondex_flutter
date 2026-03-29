class PokemonDetailModel {
  final String id;
  final String name;
  final double heightInMeters;
  final double weightInKg;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  PokemonDetailModel({
    required this.id,
    required this.name,
    required this.heightInMeters,
    required this.weightInKg,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });
}
