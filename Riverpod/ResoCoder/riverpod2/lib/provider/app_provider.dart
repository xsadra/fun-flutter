import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod2/data/data.dart';

final wsClientProvider = Provider<WebSocketClient>(
  (ref) => FakeWSClient(),
);

final counterProvider = StreamProvider.family<int, int>((ref, start) {
  final wsClient = ref.watch(wsClientProvider);
  return wsClient.getCounterStream(start);
});
