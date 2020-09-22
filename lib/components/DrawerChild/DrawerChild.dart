import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerChild extends StatelessWidget {
  const DrawerChild();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
            padding: EdgeInsets.all(0),
            child: Container(
              color: Color.fromRGBO(62, 32, 109, 1),
              child: SvgPicture.asset(
                'images/logo.svg',
                fit: BoxFit.scaleDown,
              ),
            )),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          title: Row(
            children: [
              Icon(
                Icons.home_outlined,
                size: 17,
                color: Color.fromRGBO(62, 32, 109, 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Color.fromRGBO(62, 32, 109, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/favorite');
          },
          title: Row(
            children: [
              Icon(
                Icons.favorite_border_outlined,
                size: 17,
                color: Color.fromRGBO(62, 32, 109, 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Favorites',
                  style: TextStyle(
                    color: Color.fromRGBO(62, 32, 109, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
