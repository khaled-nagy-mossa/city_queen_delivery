import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';

import '../cubit/contact_us/cubit.dart';
import '../model/contact_us.dart';
import 'company_data_node.dart';

class BranchContactData extends StatelessWidget {
  final ContactUs contactUs;

  const BranchContactData({@required this.contactUs})
      : assert(contactUs != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CompanyDataNode(
            toolTip: 'Phone'.tr,
            svg: Assets.images.telephone,
            title: contactUs.phone,
            onTap: () {
              ContactUsViewCubit.get(context)
                  .launchToPhone(context, contactUs.phone);
            },
          ),
          const Divider(),
          CompanyDataNode(
            toolTip: 'E-mail'.tr,
            svg: Assets.images.email,
            title: contactUs.email,
            onTap: () {
              ContactUsViewCubit.get(context)
                  .launchToEmail(context, contactUs.email);
            },
          ),
        ],
      ),
    );
  }
}
