import 'package:blox/data/blox/core/blox_core.dart';
import 'package:blox/data/blox/core/events_core.dart';
import 'package:blox/data/blox/core/states_core.dart';
import 'package:blox/data/domain/core/repository_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BloxBuilder<T> extends StatelessWidget {
  final Repository<T> repository;
  final bool autoFetch;

  final Widget Function(BuildContext context, List<T> data)? builder;
  final Widget Function(BuildContext context, String error)? failure;
  final Widget Function(BuildContext context, T dataMap)? postData;

  const BloxBuilder({
    super.key,
    required this.repository,
    this.autoFetch = true,
    required this.builder,
    this.failure,
    this.postData,
  });

  Widget errorBuilder(BuildContext context, String errorMessage) {
    if (failure != null) {
      return failure!(context, errorMessage);
    }
    return Text(errorMessage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Blox<T>>(
      create: (context) {
        final bloc = Blox<T>(repository: repository);
        if (autoFetch) {
          bloc.add(const GetDataEvent());
        }
        return bloc;
      },
      child: BlocBuilder<Blox<T>, States>(
        builder: (context, state) {
          switch (state) {
            case LoadingState():
              return CircularProgressIndicator();

            case ResponseState<T>():
              return state.response.fold(
                (errorMessage) => errorBuilder(context, errorMessage),
                (dataList) =>
                    builder?.call(context, dataList) ?? const SizedBox.shrink(),
              );

            case SubmitState<T>():
              return state.result.fold(
                (errorMessage) => errorBuilder(context, errorMessage),
                (responseData) =>
                    postData?.call(context, responseData) ??
                    const SizedBox.shrink(),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
