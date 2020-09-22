import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Favorites/Favorites.dart';

class CustomCard extends StatefulWidget {
  final url;

  CustomCard({Key key, this.url}) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final favoriteData = Provider.of<Favorites>(context);
    final isFavorite = favoriteData.isFavorite(this.widget.url);

    void handleDoubelTap() {
      if (isFavorite) {
        favoriteData.removeFromFavorites(this.widget.url);

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Removed from favorites'),
          action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                favoriteData.addToFavorites(this.widget.url);
              }),
        ));
      } else {
        favoriteData.addToFavorites(this.widget.url);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Added to favorites!')));
      }
    }

    return GestureDetector(
      onDoubleTap: () {
        handleDoubelTap();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                this.widget.url,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Container(
                width: double.maxFinite,
                height: 30,
                color: Color.fromRGBO(145, 109, 213, 0.5),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            handleDoubelTap();
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}