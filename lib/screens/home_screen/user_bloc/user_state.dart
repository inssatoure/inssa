import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class Authenticated extends UserState {
  final User user;

  Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends UserState {}

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigatedToResume extends NavigationState {
  final String resumeId;

  NavigatedToResume(this.resumeId);

  @override
  List<Object> get props => [resumeId];
}
