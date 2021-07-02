import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:recipes/recipes/model/recipes.dart';

part 'recipes_event.dart';

part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc() : super(const RecipesState());

  @override
  Stream<RecipesState> mapEventToState(
    RecipesEvent event,
  ) async* {
    if (event is RecipesEvent) {
      yield await mapFetchedToState(state);
    }
  }

  Future<RecipesState> mapFetchedToState(RecipesState state) async {
    if (state.ready) return state;
    try {
      if (state.status == RecipesStatus.initial) {
        final recipes = await fetch();
        return state.copyWith(
          status: RecipesStatus.success,
          posts: recipes,
          hasReachedMax: false,
        );
      }
      final recipes = await fetch();
      return recipes.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: RecipesStatus.success,
              posts: List.of(state.posts)..addAll(recipes),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: RecipesStatus.failure);
    }
  }

  Future<List<Recipes>> fetch() async {
    final response = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/ababicheva/FlutterInternshipTestTask/main/recipes.json',
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Recipes(
          id: json['id'] as int,
          name: json['name'] as String,
          picture: json['picture'] as String,
          description: json['description'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
