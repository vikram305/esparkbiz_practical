import 'package:flutter_bloc/flutter_bloc.dart';
class SimpleBlocDelegate extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

//  @override
//  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
//    super.onError(bloc, error, stacktrace);
//    print(error);
//  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}