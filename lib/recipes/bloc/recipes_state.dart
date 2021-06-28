part of 'recipes_bloc.dart';

enum RecipesStatus { initial, success, failure }

class RecipesState {
  const RecipesState({
    this.status = RecipesStatus.initial,
    this.posts = const <Recipes>[],
    this.ready = false,
  });

  final RecipesStatus status;
  final List<Recipes> posts;
  final bool ready;

  RecipesState copyWith({
    RecipesStatus? status,
    List<Recipes>? posts,
    bool? hasReachedMax,
  }) {
    return RecipesState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      ready: hasReachedMax ?? this.ready,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $ready, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, ready];
}
