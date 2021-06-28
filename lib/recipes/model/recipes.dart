import 'package:equatable/equatable.dart';

class Recipes extends Equatable {
  const Recipes({
    required this.id,
    required this.name,
    required this.picture,
    required this.description,
  });

  final int id;
  final String name;
  final String picture;
  final String description;

  @override
  List<Object> get props => [id, name, picture, description];
}
