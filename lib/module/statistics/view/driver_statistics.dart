import 'package:delivery/main_imports.dart';
import 'package:delivery/module/global/view/exception_view.dart';
import 'package:delivery/module/statistics/cubit/delivery/cubit.dart';
import 'package:delivery/module/statistics/cubit/delivery/states.dart';
import 'package:delivery/module/statistics/widget/chart.dart';
import 'package:delivery/module/statistics/widget/collected_money.dart';
import 'package:delivery/module/statistics/widget/date_picker.dart';
import 'package:delivery/module/statistics/widget/more_tab.dart';
import 'package:delivery/widget/app_bar/default_app_bar.dart';
import 'package:delivery/widget/app_snack_bar/app_snack_bar.dart';
import 'package:delivery/widget/default_body.dart';
import 'package:delivery/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../model/driver_profile.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({Key key}) : super(key: key);

  static const routeName = 'statistics_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeliveryCubit>(
      create: (context) => DeliveryCubit(
        deliveryId: AccountCubit.get(context).user.data.id,
      ),
      child: Builder(
        builder: (context) {
          return BlocConsumer<DeliveryCubit, DeliveryStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              final cubit = DeliveryCubit.get(context);

              if (state is FetchingDataState || state is InitialState) {
                return const Scaffold(body: LoadingWidget(color: Colors.white));
              } else if (state is IneffectiveErrorState) {
                return ExceptionView(
                  exceptionMsg: state.error,
                  title: '',
                );
              }

              return Scaffold(
                appBar: DefaultAppBar(title: Text('STATISTICS'.tr)),
                body: DefaultBody(
                  child: Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(10.0),
                        children: [
                          CollectedMoneyWidget(
                            totalCollected: cubit.profile.totalCollected,
                            totalEarning: cubit.profile.totalEarning,
                          ),
                          const SizedBox(height: 20.0),
                          DatePickerWidget(
                            from: cubit.startMonth,
                            to: cubit.endMonth,
                            onChanged: cubit.changeDuration,
                          ),
                          ChartWidget(orders: cubit.profile.counts),
                          const SizedBox(height: 20.0),
                          MoreTab(labels: cubit.profile.counts),
                        ],
                      ),
                      if (state is LoadingState) const LoadingWidget(),
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
}
