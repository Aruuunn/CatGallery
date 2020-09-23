import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/home.dart';
import './models/Favorites/Favorites.dart';
import './models/CatPhotos/CatPhotos.dart';
import './screens/favorites.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: ChangeNotifierProvider(
        child: MaterialApp(
          title: 'Cat Gallery',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(color: Color.fromRGBO(62, 32, 109, 1)),
            canvasColor: Color.fromRGBO(240, 227, 255, 1),
          ),
          initialRoute: '/',
          home: Home(),
          routes: {'/favorite': (ctx) => FavoriteScreen()},
        ),
        create: (ctx) => Favorites(),
      ),
      create: (ctx) => CatPhotos(),
    );
  }
}
