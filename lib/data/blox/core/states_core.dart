import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class States extends Equatable {
  const States();
}

class InitialState extends States {
  const InitialState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends States {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class ResponseState<T> extends States {
  final Either<String, List<T>> response;
  const ResponseState(List<Object?> data, {required this.response});

  @override
  List<Object?> get props => [response];
}

class SubmitState<T> extends States {
  final Either<String, T> result;
  const SubmitState({required this.result});

  @override
  List<Object?> get props => [result];
}

class ErrorState<T> extends States {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
