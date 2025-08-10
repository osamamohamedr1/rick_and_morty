import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('bloc changed $bloc $change');
  }

  @override
  void onClose(BlocBase bloc) {
    log('bloc closed $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('bloc created $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('bloc onTransition $bloc , $transition');
  }
}
