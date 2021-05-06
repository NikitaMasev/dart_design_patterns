abstract class GameAi {
  ///Template method(function), that represents carcass of algorithm.
  void turn() {
    collectResources();
    buildStructures();
    buildUnit();
  }

  ///Template method(function), that represents carcass of algorithm.
  void collectResources() {
    hit();
    shatter();
    take();
  }

  void hit();

  void shatter();

  void take();

  void buildStructures();

  void buildUnit();
}

class OrcsAi extends GameAi {
  final int intelligence;

  static const _MIN_INTELLIGENCE_BUILD = 20;

  OrcsAi(this.intelligence);

  @override
  void buildStructures() {
    if (intelligence < _MIN_INTELLIGENCE_BUILD) {
      print('Orcs cant buildStructures');
    } else {
      print('Orcs buildStructures');
    }
  }

  @override
  void buildUnit() {
    if (intelligence < _MIN_INTELLIGENCE_BUILD) {
      print('Orcs cant buildUnit');
    } else {
      print('Orcs buildUnit');
    }
  }

  @override
  void hit() {
    print('Orcs hit');
  }

  @override
  void shatter() {
    print('Orcs shatter');
  }

  @override
  void take() {
    print('Orcs take');
  }
}

class MonstersAi extends GameAi {
  @override
  void buildStructures() {
    print('Monsters cant buildStructures');
  }

  @override
  void buildUnit() {
    print('Monsters cant buildUnit');
  }

  @override
  void hit() {
    print('Monsters hit');
  }

  @override
  void shatter() {
    print('Monsters cant shatter');
  }

  @override
  void take() {
    print('Monsters cant take');
  }
}

class Game {
  final List<GameAi> _gamesAi;

  Game(this._gamesAi);

  void start() {
    _gamesAi.forEach((gameAi) => gameAi.turn());
  }
}

void main() {
  final game = Game([OrcsAi(10), MonstersAi()]);
  game.start();
}
