import 'package:equatable/equatable.dart';
import 'package:pet_app/models/api_response.dart';
import 'package:pet_app/models/authorization.dart';

abstract class AuthState extends Equatable {}

class AuthUninitialized extends AuthState {
  @override
  String toString() => 'AuthUninitialized';
}

class AuthAuthenticated extends AuthState {
  final AuthResponse response;

  AuthAuthenticated({
    this.response
  });

  @override
  String toString() => 'AuthAuthenticated';
}

class AuthUnauthenticated extends AuthState {
  final APIError error;

  String get message => error?.message ?? 'Generic Error';

  AuthUnauthenticated({
    this.error
  });

  @override
  String toString() => 'AuthUnauthenticated';
}

class AuthLoading extends AuthState {
  @override
  String toString() => 'AuthLoading';
}
