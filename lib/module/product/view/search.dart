import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../widget/app_bar/default_app_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(title: Text('Search'.tr)),
        body: Center(
          child: Text('Search View'.tr),
        ));
  }
}
