import 'dart:typed_data';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../widget/app_bar/default_app_bar.dart';
import '../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../../widget/default_body.dart';
import '../../../../widget/elevated_button_extension.dart';
import '../../../../widget/loading_widget.dart';
import '../../cubit/confirm_signature/cubit.dart';
import '../../cubit/confirm_signature/states.dart';
import 'order_delivered.dart';

class ConfirmSignatureView extends StatelessWidget {
  final Uint8List uint8list;
  final int orderId;
  final String paidAmount;

  const ConfirmSignatureView({
    @required this.uint8list,
    @required this.orderId,
    @required this.paidAmount,
  })  : assert(uint8list != null),
        assert(paidAmount != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfirmSignatureCubit>(
      create: (context) => ConfirmSignatureCubit(orderId: orderId),
      child: BlocConsumer<ConfirmSignatureCubit, ConfirmSignatureStates>(
        listener: (context, state) async {
          if (state is IneffectiveError) {
            AppSnackBar.error(context, state.error);
          } else if (state is SubmittedState) {
            await AppRoutes.push(context, OrderDeliveredView(orderId: orderId));
          }
        },
        builder: (context, state) {
          final cubit = ConfirmSignatureCubit.get(context);
          return Stack(
            children: [
              Scaffold(
                appBar: DefaultAppBar(
                  title: Text('Confirm Your Signature'.tr),
                ),
                body: DefaultBody(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Container(
                          color: Colors.grey[300],
                          child: Image.memory(uint8list),
                        ),
                        Expanded(child: Container()),
                        ElevatedButton(
                          onPressed: () async {
                            await cubit.uploadSignature(uint8list);
                            await cubit.submitOrder(paidAmount, orderId);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 40.0),
                          ),
                          child: const Text(
                            'Send Signature',
                            style: TextStyle(color: Colors.white),
                          ),
                        ).toGradient(context),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is LoadingState) const LoadingWidget(),
            ],
          );
        },
      ),
    );
  }
}
