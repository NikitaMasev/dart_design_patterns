abstract class EventListener<T> {
  void onData(T t);
}

abstract class EventNotifier<T> {
  void notify(T t);
}

class EventManager<T> implements EventNotifier<T> {
  final List<EventListener<T>> _listeners = [];

  void subscribe(EventListener<T> eventListener) {
    _listeners.add(eventListener);
  }

  void unsubscribe(EventListener<T> eventListener) {
    _listeners.remove(eventListener);
  }

  @override
  void notify(T t) {
    _listeners.forEach((listener) => listener.onData(t));
  }
}

///Class that can push events for listeners.
class Editor {
  final EventNotifier<String> _notifier;

  Editor(this._notifier);

  void openFile() {
    _notifier.notify('File opened');
  }
}

///Consumer of events, which pushed by [Editor].
class Logging implements EventListener<String> {
  @override
  void onData(String t) {
    print('Logging: $t');
  }
}

void main() {
  final log = Logging();
  final eventManager = EventManager<String>();
  eventManager.subscribe(log);

  final editor = Editor(eventManager);
  editor.openFile();
}
