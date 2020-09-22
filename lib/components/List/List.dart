import 'package:cat_gallery/components/Card/Card.dart';
import 'package:cat_gallery/models/CatPhotos/CatPhotos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class List extends StatefulWidget {
  @required
  final images;

  List({this.images, Key key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    final loadMore = Provider.of<CatPhotos>(context).load;
    return NotificationListener(
      onNotification: (t) {
        if (t is ScrollEndNotification) {
          loadMore();
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: this.widget.images.length,
          itemBuilder: (ctx, i) =>
              CustomCard(url: this.widget.images[i], key: ValueKey(i)),
        ),
      ),
    );
  }
}
