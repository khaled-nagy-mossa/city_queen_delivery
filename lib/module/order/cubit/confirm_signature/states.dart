import 'package:flutter/cupertino.dart';

import '../../../../model/order/order.dart';

abstract class ConfirmSignatureStates {
  const ConfirmSignatureStates();
}

class InitialState extends ConfirmSignatureStates {
  const InitialState() : super();
}

class LoadingState extends ConfirmSignatureStates {
  const LoadingState() : super();
}

class SignatureUploadedState extends ConfirmSignatureStates {
  const SignatureUploadedState() : super();
}

class SubmittedState extends ConfirmSignatureStates {
  final Order order;

  const SubmittedState({@required this.order}) : super();
}

class IneffectiveError extends ConfirmSignatureStates {
  final String error;

  const IneffectiveError({@required this.error}) : super();
}
