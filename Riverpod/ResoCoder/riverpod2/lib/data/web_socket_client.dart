abstract class WebSocketClient {
  Stream<int> getCounterStream();
}

class FakeWSClient implements WebSocketClient {
  @override
  Stream<int> getCounterStream() async* {
    int counter = 0;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield counter++;
    }
  }
}
