import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserCheckRequested extends UserEvent {}

class UserChanged extends UserEvent {
  final User? user;

  UserChanged({required this.user});

  @override
  List<Object> get props => [user ?? Object()];
}

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToResume extends NavigationEvent {
  final String resumeId;

  NavigateToResume(this.resumeId);

  @override
  List<Object> get props => [resumeId];
}
