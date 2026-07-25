// core/error/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Serverdə xəta baş verdi']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Lokal yaddaşda xəta baş verdi']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'İnternet bağlantısı yoxdur']);
}
