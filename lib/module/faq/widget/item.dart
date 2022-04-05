import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../model/faq.dart';

class FaqItem extends StatelessWidget {
  final Faq model;

  const FaqItem({@required this.model}) : assert(model != null);

  static final _controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    try {
      return Card(
        child: ExpandablePanel(
          header: ListTile(title: Text(model?.question ?? ''.tr)),
          controller: _controller,
          collapsed: Container(),
          expanded: Container(
            alignment: Alignment.center,
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: HtmlWidget(model?.answer ?? ''.tr),
          ),
        ),
      );
    } catch (e) {
      log('Exception in FaqItem : $e'.tr);
      return const SizedBox();
    }
  }
}
