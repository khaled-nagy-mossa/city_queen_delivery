import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../../../model/order/order.dart';
import '../../../../widget/app_bar/default_app_bar.dart';
import '../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../../widget/custom_shadow.dart';
import '../../../../widget/default_body.dart';
import '../../../../widget/loading_widget.dart';
import '../../cubit/payment/cubit.dart';
import '../../cubit/payment/states.dart';
import '../../widget/finish_btn.dart';
import '../../widget/order_price.dart';
import '../../widget/signature_button.dart';
import 'order_delivered.dart';
import 'signature_view.dart';

class OrderPaymentView extends StatelessWidget {
  static const routeName = '/order_payment_view';
  final Order order;

  const OrderPaymentView({@required this.order, Key key})
      : assert(order != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (order == null || order.unusable) {
      log('navigate back because order == null || order.unUsable'.tr);

      AppRoutes.pop(context);
    }

    return BlocProvider<PaymentViewCubit>(
      create: (context) => PaymentViewCubit(order: order),
      child: BlocConsumer<PaymentViewCubit, PaymentViewStates>(
        listener: (context, state) async {
          if (state is IneffectiveError) {
            AppSnackBar.error(context, state.error);
          } else if (state is SubmittedState) {
            await AppRoutes.pushReplacement(
              context,
              OrderDeliveredView(orderId: order.id),
            );
          }
        },
        builder: (context, state) {
          final cubit = PaymentViewCubit.get(context);
          return Stack(
            children: [
              Scaffold(
                appBar: DefaultAppBar(title: Text('Payment'.tr)),
                body: DefaultBody(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ListView(
                      children: [
                        OrderPriceWidget(
                          price:
                              '${order?.total?.toString()} ${order.currency}',
                          title: 'Order Amount',
                        ),
                        const SizedBox(height: 50.0),
                        Center(
                          child: CustomShadow(
                            child: Card(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 30.0,
                                ),
                                child: OrderPriceWidget(
                                  price:
                                      '${cubit.paidAmount} ${order?.currency}',
                                  title: 'Order Amount',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        NumericKeyboard(
                          onKeyboardTap: cubit.addToPaidAmount,
                          rightButtonFn: cubit.deleteFromPaidAmount,
                          rightIcon: const Icon(
                            Icons.backspace,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SignatureButton(
                          onTap: () async {
                            final validated = await cubit.validatePaidAmount();
                            if (validated) {
                              await AppRoutes.push(
                                context,
                                SignatureView(
                                  orderId: order.id,
                                  currency: order.currency,
                                  paidAmount: cubit.paidAmount,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10.0),
                        FinishButton(title: 'Submit', onTap: cubit.submitOrder),
                        const SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is LoadingState) const LoadingWidget()
            ],
          );
        },
      ),
    );
  }
}
