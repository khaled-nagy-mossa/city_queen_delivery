import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/order/order.dart';
import '../../repositories/service.dart';
import 'states.dart';

class ConfirmSignatureCubit extends Cubit<ConfirmSignatureStates> {
  final int orderId;

  ConfirmSignatureCubit({@required this.orderId})
      : assert(orderId != null),
        super(const InitialState());

  factory ConfirmSignatureCubit.get(BuildContext context) {
    return BlocProvider.of<ConfirmSignatureCubit>(context);
  }

  Future<void> uploadSignature(Uint8List uint8list) async {
    try {
      await Future<void>.delayed(Duration.zero);
      emit(const LoadingState());

      final imageEncoded = base64.encode(uint8list);

      final Object result = await OrderService.signOrder(
        orderId: orderId,
        imageEncoded: imageEncoded,
      );

      if (result is! Order) throw result.toString();

      if (result is Order) {
        emit(const SignatureUploadedState());
      }
    } catch (e) {
      emit(IneffectiveError(error: e.toString()));
    }
  }

  //client update [i don't know why?]
  Future<void> submitOrder(String paidAmount, int orderId) async {
    assert(paidAmount != null);
    assert(orderId != null);
    try {
      await Future<void>.delayed(Duration.zero);

      emit(const LoadingState());

      final Object res = await OrderService.updateOrderStatusToDelivered(
        totalPrice: double.parse(paidAmount),
        orderId: orderId,
      );

      if (res is! Order) throw res.toString();

      if (res is Order) {
        emit(SubmittedState(order: res));
      }
    } catch (e) {
      emit(IneffectiveError(error: e.toString()));
    }
  }
}
