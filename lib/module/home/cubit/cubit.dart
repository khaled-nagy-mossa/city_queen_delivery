import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/home.dart';
import '../repositories/service.dart';
import 'states.dart';

class HomeViewCubit extends Cubit<HomeViewStates> {
  HomeViewModel model;

  HomeViewCubit() : super(const InitialState()) {
    initial();
  }

  factory HomeViewCubit.get(BuildContext context) {
    return BlocProvider.of<HomeViewCubit>(context);
  }

  Future<void> initial() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await HomeViewService.homePage();

      if (result is String) throw result;

      if (result is HomeViewModel) {
        model = result;

        emit(const HasInitState());
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(Duration.zero);
    emit(const RefreshState());
    await initial();
  }
}
