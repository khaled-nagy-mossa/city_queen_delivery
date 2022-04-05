import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/states.dart';
import '../view/notifications.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SignedState) {
          return GestureDetector(
            onTap: () {
              AppRoutes.push(context, const NotificationsView());
            },
            child: Container(
              ///adding color t enable margin area to be clickable
              color: Colors.white.withOpacity(0.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                constraints: BoxConstraints.tight(const Size(22.0, 22.0)),
                child: SvgPicture.asset(Assets.images.notifications),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
