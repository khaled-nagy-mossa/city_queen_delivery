import 'package:delivery/shared_widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/location_monitor.dart';
import '../../../main_imports.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/default_body.dart';
import '../../../widget/loading_widget.dart';
import '../../global/widget/exception.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../widget/chart.dart';
import '../widget/collected_money.dart';
import '../widget/orders_list.dart';
import '../widget/welcome.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home_view';

  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationMonitor.init(context: context);

    return BlocProvider<HomeViewCubit>(
      create: (context) => HomeViewCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<HomeViewCubit, HomeViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              return Scaffold(
                drawer: const DrawerWidget(),
                appBar: const DefaultAppBar(
                  bottom: PreferredSize(
                    preferredSize: Size(double.infinity, 100.0),
                    child: WelcomeWidget(),
                  ),
                ),
                body: DefaultBody(
                  child: Stack(
                    children: [
                      _body(context, state),
                      if (state is RefreshState) const LoadingWidget(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, HomeViewStates state) {
    final cubit = HomeViewCubit.get(context);
    if (state is InitialState) {
      return const LoadingWidget(color: Colors.transparent);
    } else if (state is ExceptionState) {
      return ExceptionWidget(
        onRefresh: cubit.refresh,
        exceptionMsg: state.error,
      );
    } else {
      return RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: [
            CollectedMoneyWidget(
              totalCollected: cubit?.model?.totalCollected ?? '0.0',
              totalEarning: cubit?.model?.totalEarning ?? '0.0',
            ),
            const SizedBox(height: 14.0),
            ChartWidget(orders: cubit?.model?.ordersLabel),
            const SizedBox(height: 14.0),
            OrdersList(orders: cubit.model.inDeliveryOrders),
          ],
        ),
      );
    }
  }
}
