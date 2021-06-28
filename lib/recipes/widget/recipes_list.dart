import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipes/recipes/model/recipes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recipes_List extends StatelessWidget {
  const Recipes_List({Key? key, required this.recipes}) : super(key: key);
  final Recipes recipes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
        children: [
          ListTile(
            leading: CachedNetworkImage(
              width: 90.0,
              height: 100.0,
              key: UniqueKey(),
              imageUrl: recipes.picture.toString(),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.black12,
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            title: Text(recipes.name.toString(),
                style: TextStyle(fontSize: 15.sp)),
            subtitle: Text(
              recipes.description.toString(),
              style: TextStyle(fontSize: 13.sp),
            ),
            trailing: Text(
              recipes.id.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(125, 0, 0, 0), child: Divider()),
        ],
      ),
    );
  }
}
