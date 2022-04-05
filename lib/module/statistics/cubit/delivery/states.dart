import 'package:flutter/material.dart';

abstract class DeliveryStates {
  const DeliveryStates();
}

class InitialState extends DeliveryStates {
  const InitialState() : super();
}

class FetchingDataState extends DeliveryStates {
  const FetchingDataState() : super();
}

class FetchedDataState extends DeliveryStates {
  const FetchedDataState() : super();
}

class LoadingState extends DeliveryStates {
  const LoadingState() : super();
}

class LoadedState extends DeliveryStates {
  const LoadedState() : super();
}

class IneffectiveErrorState extends DeliveryStates {
  const IneffectiveErrorState({@required this.error}) : super();

  final String error;
}

class ExceptionState extends DeliveryStates {
  const ExceptionState({@required this.error}) : super();

  final String error;
}
