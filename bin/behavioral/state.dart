abstract class State {
  bool playing = false;

  final PlayerStateControl playerStateControl;

  State(this.playerStateControl);

  void lock();

  void stop();

  void play();

  void pause();

  void next();

  void previous();
}

class LockedState extends State {
  LockedState(PlayerStateControl playerStateControl)
      : super(playerStateControl);

  ///After unlocking player.
  @override
  void lock() {
    if (playing) {
      playerStateControl.changeState(PlayingState(playerStateControl));
    } else {
      playerStateControl.changeState(ReadyState(playerStateControl));
    }
  }

  @override
  void next() {
  }

  @override
  void pause() {
  }

  @override
  void play() {
  }

  @override
  void previous() {
  }

  @override
  void stop() {
  }
}

class ReadyState extends State {
  ReadyState(PlayerStateControl playerStateControl) : super(playerStateControl);

  @override
  void lock() {
    playerStateControl.changeState(LockedState(playerStateControl));
  }

  @override
  void next() {
    playerStateControl.next();
  }

  @override
  void pause() {
  }

  @override
  void play() {
    playing = true;
    playerStateControl.play();
    playerStateControl.changeState(PlayingState(playerStateControl));
  }

  @override
  void previous() {
    playerStateControl.previous();
  }

  @override
  void stop() {
  }
}

class PlayingState extends State {
  PlayingState(PlayerStateControl playerStateControl)
      : super(playerStateControl);

  @override
  void lock() {
    playerStateControl.changeState(LockedState(playerStateControl));
  }

  @override
  void next() {
    playerStateControl.next();
  }

  @override
  void pause() {
    playerStateControl.pause();
    playerStateControl.changeState(ReadyState(playerStateControl));
  }

  @override
  void play() {
  }

  @override
  void previous() {
    playerStateControl.previous();
  }

  @override
  void stop() {
    playerStateControl.stop();
    playerStateControl.changeState(ReadyState(playerStateControl));
  }
}

abstract class PlayerStateControl {
  void stop();

  void play();

  void pause();

  void next();

  void previous();

  void changeState(State state);
}

abstract class UiPLayer {
  void clickStop();

  void clickPlay();

  void clickPause();

  void clickNext();

  void clickPrevious();

  void clickLock();
}

class AudioPlayer extends PlayerStateControl implements UiPLayer {
  late State state;

  @override
  void changeState(State state) {
    this.state = state;
    print('STATE CHANGED ${state.runtimeType.toString()}');
  }

  @override
  void next() {
    print('NEXT');
  }

  @override
  void pause() {
    print('PAUSE');
  }

  @override
  void play() {
    print('PLAY');
  }

  @override
  void previous() {
    print('PREVIOUS');
  }

  @override
  void stop() {
    print('STOP');
  }

  @override
  void clickLock() {
    state.lock();
  }

  @override
  void clickNext() {
    state.next();
  }

  @override
  void clickPause() {
    state.pause();
  }

  @override
  void clickPlay() {
    state.play();
  }

  @override
  void clickPrevious() {
    state.previous();
  }

  @override
  void clickStop() {
    state.stop();
  }
}

class Application {
  final UiPLayer _uiPLayer;

  Application(this._uiPLayer);

  void test() {
    _uiPLayer.clickPlay();
    _uiPLayer.clickNext();
    _uiPLayer.clickPause();
    _uiPLayer.clickPrevious();
    _uiPLayer.clickStop();
    _uiPLayer.clickLock();
  }
}

void main() {
  final player = AudioPlayer();
  final initState = ReadyState(player);
  player.changeState(initState);

 final app  = Application(player);
 app.test();
}