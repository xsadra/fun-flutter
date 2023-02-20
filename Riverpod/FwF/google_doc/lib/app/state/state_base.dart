import 'package:equatable/equatable.dart';

import '../../models/app_error.dart';

class StateBase extends Equatable {
  const StateBase({this.error});

  final AppError? error;

  @override
  List<Object?> get props => [error];
}
