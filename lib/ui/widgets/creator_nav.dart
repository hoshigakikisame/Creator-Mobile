import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CreatorNav extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFCD5E),
      elevation: 0.0,
      actions: [
        PopupMenuButton(
          icon: Icon(
            CupertinoIcons.line_horizontal_3,
            color: Colors.white,
          ),
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: Text("Tentang Kami"),
              value: 0,
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              child: Text("Roda Kopi"),
              value: 1,
            ),
          ],
          onSelected: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  RouteTo(
                    AboutPage(),
                  ),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  RouteTo(
                    RodaKopiPage(),
                  ),
                );
                break;
            }
          },
        ),
      ],
    );
  }
}
