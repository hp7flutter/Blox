import 'package:equatable/equatable.dart';

abstract class Events extends Equatable {
  const Events();
}

class GetDataEvent extends Events {
  const GetDataEvent();

  @override
  List<Object?> get props => [];
}

class PostDataEvent extends Events {
  final Map<String, dynamic> postData;

  const PostDataEvent(this.postData);

  @override
  List<Object?> get props => [postData];
}
