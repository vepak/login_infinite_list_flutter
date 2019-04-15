import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}

class AuthenticationLogin extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLogin';
}

class AuthenticationSignup extends AuthenticationState {
  @override
  String toString() => 'AuthenticationSignup';
}

class AuthenticationDemo extends AuthenticationState {
  @override
  String toString() => 'AuthenticationDemo';
}

