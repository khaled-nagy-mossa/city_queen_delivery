import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class PickImageBottomSheet extends StatelessWidget {
  final void Function(ImageSource source) onPicked;

  const PickImageBottomSheet({@required this.onPicked})
      : assert(onPicked != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () => onPicked(ImageSource.camera),
          title: Text(
            'Camera'.tr,
          ),
        ),
        ListTile(
          onTap: () => onPicked(ImageSource.gallery),
          title: Text(
            'Gallery'.tr,
          ),
        )
      ],
    );
  }
}
