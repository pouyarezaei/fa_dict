import 'package:flutter/material.dart';

import '../color_palette.dart';

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text("کلمه"),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            (index) % 2 == 0 ? Icons.favorite_border : Icons.favorite,
            color: ColorPalette.mandy,
          ),
        ),
        trailing: Text(
          "Word",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
