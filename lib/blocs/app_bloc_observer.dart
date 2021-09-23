import 'package:bloc/bloc.dart';

//* For debugging purpose
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('\nEvent: $event\n');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('\nError: $error\n');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('\nChange: $change\n');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('\nTransition: $transition\n');
  }
}
