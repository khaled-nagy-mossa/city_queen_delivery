import 'package:flutter/material.dart';

import '../common/const/app_data.dart';
import '../main_imports.dart';

class DefaultBody extends StatelessWidget {
  final Widget child;
  final Color color;

  const DefaultBody({@required this.child, this.color, Key key})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(gradient: AppData.gradient),
        ),
        Card(
          margin: EdgeInsets.zero,
          elevation: 12.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).scaffoldBackgroundColor,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
