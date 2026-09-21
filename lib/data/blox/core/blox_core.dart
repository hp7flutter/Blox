import 'package:blox/data/blox/core/events_core.dart';
import 'package:blox/data/blox/core/states_core.dart';
import 'package:blox/data/domain/core/repository_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blox<T> extends Bloc<Events, States> {
  final Repository<T> repository;

  Blox({required this.repository}) : super(const InitialState()) {
    on<GetDataEvent>(_onGetData);
    on<PostDataEvent>(_onPostData);
  }

  Future<void> _onGetData(GetDataEvent event, Emitter<States> emit) async {
    emit(const LoadingState());

    final response = await repository.getData();

    response.fold(
      (failure) => emit(ErrorState(failure)),
      (data) => emit(ResponseState<T>(data, response: response)),
    );
  }

  Future<void> _onPostData(PostDataEvent event, Emitter<States> emit) async {
    emit(const LoadingState());

    final result = await repository.postData(dataMap: event.postData);

    result.fold(
      (failure) => emit(ErrorState(failure)),
      (data) => emit(SubmitState<T>(result: result)),
    );
  }
}
