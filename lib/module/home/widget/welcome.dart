import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../chat/common/chat_view_imports.dart';
import '../../profile/cubit/account/cubit.dart';
import '../../profile/cubit/account/states.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME_BACK'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    AccountCubit?.get(context)
                            ?.user
                            ?.data
                            ?.name
                            ?.toUpperCase() ??
                        '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
