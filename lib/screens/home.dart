import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/Appbar/Appbar.dart';
import '../components/List/List.dart';
import '../components/DrawerChild/DrawerChild.dart';
import '../models/CatPhotos/CatPhotos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<CatPhotos>(context).isLoading;
    return Scaffold(
      appBar: CustomAppbar(
        title: "Cat Gallery",
      ),
      body:!isLoading? Consumer<CatPhotos>(
        builder: (ctx, catphotos, child) => List(
          images: catphotos.images,
        ),
      ):Center(
        child: CircularProgressIndicator(),
      ),
      endDrawer: Drawer(child: const DrawerChild()),
    );
  }
}
