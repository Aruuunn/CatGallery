import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

import '../../models/Favorites/Favorites.dart';

class CustomCard extends StatefulWidget {
  final url;

  CustomCard({Key key, this.url}) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final favoriteData = Provider.of<Favorites>(context);
    final isFavorite = favoriteData.isFavorite(this.widget.url);

    void handleDoubelTap() {
      if (isFavorite) {
        favoriteData.removeFromFavorites(this.widget.url);

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed from favorites'),
            action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  favoriteData.addToFavorites(this.widget.url);
                }),
          ),
        );
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
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => isLoaded == false
                          ? setState(() {
                              isLoaded = true;
                            })
                          : null);
                  return Container(
                    height: 250,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(
                    height: 250,
                    color: Colors.white,
                  ),
                ),
                imageUrl: this.widget.url,
              ),
            ),
            isLoaded
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: Container(
                      width: double.maxFinite,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(145, 109, 213, 0.6),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              },
                            ),
                            Builder(
                                builder: (ctx) => IconButton(
                                      icon: Icon(
                                        Icons.share_rounded,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        _onShare(ctx);
                                      },
                                    ))
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the RaisedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The RaisedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject();

    await Share.share(widget.url,
        subject: 'Cat Photo',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
