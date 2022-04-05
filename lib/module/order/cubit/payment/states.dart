import 'package:flutter/cupertino.dart';

import '../../../../model/order/order.dart';

abstract class PaymentViewStates {
  const PaymentViewStates();
}

class InitialState extends PaymentViewStates {
  const InitialState() : super();
}

class LoadingState extends PaymentViewStates {
  const LoadingState() : super();
}

class PaidAmountUpdatedState extends PaymentViewStates {
  final String value;

  const PaidAmountUpdatedState({@required this.value}) : super();
}

class SubmittedState extends PaymentViewStates {
  final Order order;

  const SubmittedState({@required this.order}) : super();
}

class IneffectiveError extends PaymentViewStates {
  final String error;

  const IneffectiveError({@required this.error}) : super();
}
