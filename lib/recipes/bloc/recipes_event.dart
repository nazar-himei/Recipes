part of 'recipes_bloc.dart';

@immutable
abstract class RecipesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipesFetched extends RecipesEvent {}
