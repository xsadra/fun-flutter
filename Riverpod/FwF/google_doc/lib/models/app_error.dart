import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  AppError({required this.message}) {
    timestamp = DateTime.now().millisecondsSinceEpoch;
  }

  final String message;
  late final int timestamp;

  @override
  List<Object?> get props => [message, timestamp];
}
