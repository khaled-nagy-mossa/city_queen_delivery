import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    @required this.from,
    @required this.to,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  final DateTime from;
  final DateTime to;
  final void Function(DateTime from, DateTime to) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('FROM'.tr),
        TextButton(
            onPressed: () async {
              final date = await showDatePicker(
                firstDate: DateTime(2000, 4),
                lastDate: DateTime.now(),
                initialDate: from,
                context: context,
              );
              onChanged(date, to);
            },
            child: Text(
              '${from.month}-${from.year}'.tr,
            )),
        Text('TO'.tr),
        TextButton(
          onPressed: () async {
            final date = await showDatePicker(
              firstDate: DateTime(2000, 4),
              lastDate: DateTime.now(),
              initialDate: to,
              context: context,
            );
            onChanged(from, date);
          },
          child: Text('${to.month}-${to.year}'.tr),
        )
      ],
    );
  }
}
