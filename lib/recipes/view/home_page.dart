import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/recipes/bloc/recipes_bloc.dart';
import 'package:recipes/recipes/widget/recipes_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
        actions: [Icon(Icons.search)],
      ),
      body: BlocProvider(
        create: (_) => RecipesBloc()..add(RecipesFetched()),
        child: BlocBuilder<RecipesBloc, RecipesState>(
          builder: (context, state) {
            switch (state.status) {
              case RecipesStatus.failure:
                return Center(
                  child: Text('failed to fetch'),
                );
              case RecipesStatus.success:
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, i) {
                    return Recipes_List(recipes: state.posts[i]);
                  },
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
