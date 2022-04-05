import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';

class ToggleWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool selected;
  final String title;

  const ToggleWidget({
    this.onTap,
    this.selected,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: selected ? 2.0 : 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 100.0, maxHeight: 50.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            gradient: selected ? AppData.gradient : null,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : AppData.secondaryColor,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
