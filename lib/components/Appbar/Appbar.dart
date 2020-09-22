import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatefulWidget  implements PreferredSizeWidget {


  final String title;

  
  CustomAppbar({Key key,this.title}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

    @override
    final Size preferredSize;



  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'images/logo.svg',
            height: 20,
          ),
          Expanded(
              child: Text(
            this.widget.title,
            style: TextStyle(
              fontFamily: 'ArchitectsDaughter',
            ),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
