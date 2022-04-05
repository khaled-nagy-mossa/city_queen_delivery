import 'package:flutter/material.dart';

import '../../../widget/elevated_button_extension.dart';

class FinishButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FinishButton({@required this.onTap, this.title = 'Finish', Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40.0),
      ),
      onPressed: onTap,
      child: Text(title, style: const TextStyle(color: Colors.white)),
    ).toGradient(context);
  }
}
