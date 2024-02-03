import 'package:flutter/material.dart';
import 'package:fproject/shared/styles/icon_broken.dart';

class DefualtAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>?action;

   const DefualtAppBar({
    super.key,
    this.title,
    this.action,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!),
      actions: action!,
      titleSpacing: 5.0,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: const Icon(IconBroken.Arrow___Left_2)),
    );

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(57);
}
