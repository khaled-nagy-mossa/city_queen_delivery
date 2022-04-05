import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../model/order/order.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../global/widget/exception.dart';

import '../cubit/order_view/cubit.dart';
import '../cubit/order_view/states.dart';
import '../widget/order_customer.dart';
import '../widget/order_items_2.dart';
import '../widget/order_lines.dart';
import '../widget/order_price_details.dart';
import '../widget/order_view_actions.dart';

class OrderView extends StatelessWidget {
  static const routeName = '/order_view';

  final Order order;
  final int orderId;

  const OrderView({this.order, this.orderId})
      : assert(order != null || orderId != null);

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: BlocProvider<OrderViewCubit>(
        create: (context) => OrderViewCubit(order: order, orderId: orderId),
        child: BlocConsumer<OrderViewCubit, OrderViewStates>(
          listener: (context, state) {
            if (state is IneffectiveErrorState) {
              AppSnackBar.error(context, state.error);
            }
          },
          builder: (context, state) {
            final order = OrderViewCubit.get(context).order;
            return Stack(
              children: [
                Scaffold(
                  appBar: DefaultAppBar(
                    title: Row(
                      children: [Text('Order'.tr), Text(' #${order.id}')],
                    ),
                  ),
                  body: _body(context, state),
                ),
                if (state is LoadingState) const LoadingWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget get _sizedBox => const SizedBox(height: 10.0);

  Widget _body(BuildContext context, OrderViewStates state) {
    final cubit = OrderViewCubit.get(context);
    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is ExceptionState) {
      return ExceptionWidget(
        onRefresh: cubit.refresh,
        exceptionMsg: state.error,
      );
    } else {
      return RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 70.0),
          children: [
            Text('Order'.tr, style: Theme.of(context).textTheme.headline6),
            _sizedBox,
            OrderDataNode(order: order, type: cubit.orderType),
            _sizedBox,
            _sizedBox,
            if (cubit.order.status == 'in_delivery'.tr) ...[
              Text('Customer'.tr, style: Theme.of(context).textTheme.headline6),
              OrderCustomerListTile(customer: cubit?.order?.customer),
            ],
            _sizedBox,
            _sizedBox,
            Text('Order Details'.tr,
                style: Theme.of(context).textTheme.headline6),
            _sizedBox,
            OrderLines(lines: cubit?.order?.lines ?? []),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: OrderPriceDetails(order: cubit.order),
            ),
            OrderViewActions(order: order, type: cubit.orderType),
          ],
        ),
      );
    }
  }
}
