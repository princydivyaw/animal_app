import 'package:flutter/material.dart';

class DBCommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool transparent;
  final bool isLeading;
  final bool isCentreTitle;
  final double elevation;
  final double? height;
  final Color backgroundColor;
  final Color opacityColor;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;

  const DBCommonAppbar({
    super.key,
    required this.title,
    this.transparent = false,
    this.elevation = 4,
    this.backgroundColor = Colors.white,
    this.opacityColor = Colors.black,
    this.actions,
    this.leading,
    this.height,
    this.isLeading = false,
    this.isCentreTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isLeading,
      title: title,
      backgroundColor:
          transparent ? backgroundColor.withOpacity(0.5) : backgroundColor,
      elevation: elevation,
      shadowColor: opacityColor.withOpacity(0.8),
      actions: actions,
      leading: leading,
      centerTitle: isCentreTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
