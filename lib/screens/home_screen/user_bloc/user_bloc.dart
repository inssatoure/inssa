import 'dart:async';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_event.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_state.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late StreamSubscription<User?> userSubscription;

  UserBloc() : super(UserInitial()) {
    on<UserCheckRequested>(_onUserCheckRequested);
    on<UserChanged>(_onUserUserChanged);

    userSubscription =
        AuthenticationService().authStates().listen((User? user) {
      add(UserChanged(user: user));
    });
  }

  Future<void> _onUserCheckRequested(
      UserCheckRequested event, Emitter<UserState> emit) async {
    User? currentUser = AuthenticationService().getCurrentUser();
    if (currentUser != null) {
      emit(Authenticated(currentUser));
    } else {
      emit(Unauthenticated());
    }
  }

  void _onUserUserChanged(UserChanged event, Emitter<UserState> emit) {
    if (event.user != null) {
      emit(Authenticated(event.user!));
    } else {
      emit(Unauthenticated());
    }
  }
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigateToResume>(_onNavigateToResume);
  }

  void _onNavigateToResume(
      NavigateToResume event, Emitter<NavigationState> emit) {
    window.localStorage['RESUMEID'] = event.resumeId;
    emit(NavigatedToResume(event.resumeId));
  }
}
