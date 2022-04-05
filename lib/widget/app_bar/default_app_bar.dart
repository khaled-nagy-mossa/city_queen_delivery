import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../../common/const/app_data.dart';
import '../../module/notification/widget/notification_icon.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.gradient,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  });

  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final ShapeBorder shape;
  final Gradient gradient;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: NewGradientAppBar(
            leading: leading,
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: title,
            actions: actions ?? const [NotificationIcon()],
            flexibleSpace: flexibleSpace,
            bottom: bottom,
            elevation: elevation ?? 0.0,
            shape: shape,
            gradient: gradient ?? AppData.gradient,
            brightness: brightness,
            iconTheme: iconTheme,
            textTheme: textTheme,
            primary: primary,
            centerTitle: centerTitle,
            titleSpacing: titleSpacing,
            toolbarOpacity: toolbarOpacity,
            bottomOpacity: bottomOpacity,
          ),
        ),
        // Container(
        //   constraints: const BoxConstraints(maxHeight: 50.0),
        //   child: const CurvedBottomAppbar(),
        // ),
      ],
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize?.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
