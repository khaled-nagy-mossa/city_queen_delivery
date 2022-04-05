import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/order/order.dart';
import '../../repositories/service.dart';
import 'states.dart';

class PaymentViewCubit extends Cubit<PaymentViewStates> {
  final Order order;
  String _paidAmount = '';

  PaymentViewCubit({@required this.order})
      : assert(order != null),
        super(const InitialState());

  factory PaymentViewCubit.get(BuildContext context) {
    return BlocProvider.of<PaymentViewCubit>(context);
  }

  String get paidAmount {
    return (_paidAmount == null || _paidAmount.isEmpty) ? '0.0' : _paidAmount;
  }

  void addToPaidAmount(String value) {
    _paidAmount ??= '';

    if (_paidAmount == null || _paidAmount.isEmpty) {
      if (value == '0') return;
    }

    _paidAmount += value;

    emit(PaidAmountUpdatedState(value: _paidAmount));
  }

  void deleteFromPaidAmount() {
    if (_paidAmount != null && _paidAmount.isNotEmpty) {
      _paidAmount = _paidAmount.substring(0, _paidAmount.length - 1);
      emit(PaidAmountUpdatedState(value: _paidAmount));
    }
  }

  String _validatePaidAmount() {
    const errorMsg = 'invalid order amount value';
    try {
      if (_paidAmount == null || _paidAmount.isEmpty) throw errorMsg;

      final temp = double.parse(_paidAmount);

      if (temp <= 0.0) throw errorMsg;

      return '';
    } catch (e) {
      log('Exception in PaymentViewCubit.usablePaid : $e');
      return e.toString();
    }
  }

  //client update [ need that i don't know why]
  Future<bool> validatePaidAmount() async {
    try {
      await Future<void>.delayed(Duration.zero);
      final errorMsg = _validatePaidAmount();

      if (errorMsg != null && errorMsg.isNotEmpty) throw errorMsg;
      return true;
    } catch (e) {
      emit(IneffectiveError(error: e.toString()));
      return false;
    }
  }

  Future<void> submitOrder() async {
    try {
      await Future<void>.delayed(Duration.zero);
      final errorMsg = _validatePaidAmount();

      if (errorMsg != null && errorMsg.isNotEmpty) throw errorMsg;

      emit(const LoadingState());

      final Object res = await OrderService.updateOrderStatusToDelivered(
        orderId: order.id,
        totalPrice: double.parse(_paidAmount),
      );

      if (res is! Order) throw res.toString();

      if (res is Order) {
        emit(SubmittedState(order: order));
      }
    } catch (e) {
      emit(IneffectiveError(error: e.toString()));
    }
  }
}
