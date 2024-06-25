import 'package:equatable/equatable.dart';

import '../../utils/string_resource.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class TokenExpiredFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoResourceFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidUserFailure extends Failure {
  @override
  String toString() => "Identifier or password invalid";
  @override
  List<Object?> get props => [];
}

class AccountDeletedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthorizationFailure extends Failure {
  @override
  String toString() => StringResource.authorizationError;
  @override
  List<Object?> get props => [];
}

class UserPrivilegeFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CommonServerError extends Failure {
  final String error;
  const CommonServerError({required this.error});
  @override
  String toString() => error;
  @override
  List<Object?> get props => [];
}

class FormatExceptionFailure extends Failure {
  @override
  String toString() => StringResource.formatException;

  @override
  List<Object?> get props => [];
}

class LocalError extends Failure {
  final String? message;

  LocalError({
    this.message,
  });

  @override
  String toString() => message ?? '';

  @override
  List<Object?> get props => [];
}

class ServerError extends Failure {
  final String? message;

  ServerError({
    this.message,
  });

  @override
  String toString() => message ?? '';

  @override
  List<Object?> get props => [];
}
