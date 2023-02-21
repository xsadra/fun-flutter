import 'package:equatable/equatable.dart';

import '../models/app_error.dart';

class ControllerStateBase extends Equatable {
  const ControllerStateBase({this.error});

  final AppError? error;

  @override
  List<Object?> get props => [error];

  ControllerStateBase copyWith({AppError? error}) =>
      ControllerStateBase(error: error ?? this.error);
}
