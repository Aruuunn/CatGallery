import 'package:cat_gallery/components/DrawerChild/DrawerChild.dart';
import 'package:cat_gallery/components/List/List.dart';
import 'package:cat_gallery/models/Favorites/Favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/Appbar/Appbar.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Favorites',
      ),
      endDrawer: Drawer(child: const DrawerChild(),),
      body: Consumer<Favorites>(
        builder: (ctx, fav, child) => List(
          images: fav.favorites,
        ),
      ),
    );
  }
}
