import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/loading_widget.dart';
import 'cubit/auth/cubit.dart';
import 'cubit/auth/states.dart';
import 'view/registration.dart';

class AuthBlocConsumer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  const AuthBlocConsumer({@required this.navigatorKey, @required this.child})
      : assert(navigatorKey != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is SignOutState) {}
          },
          builder: (context, state) {
            if (state is InitialState) {
              return const LoadingWidget();
            }
            if (state is SignOutState) {
              return const RegistrationView();
            } else {
              return child;
            }
          },
        );
      },
    );
  }
}
