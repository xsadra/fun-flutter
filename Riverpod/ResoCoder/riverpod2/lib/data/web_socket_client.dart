abstract class WebSocketClient {
  Stream<int> getCounterStream([int start]);
}

class FakeWSClient implements WebSocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int counter = start;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      yield counter++;
    }
  }
}
