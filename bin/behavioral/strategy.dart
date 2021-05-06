abstract class Strategy {
  void execute(int a, int b);
}

class StrategyAdd implements Strategy {
  @override
  void execute(int a, int b) {
    print(a + b);
  }
}

class StrategySubtract implements Strategy {
  @override
  void execute(int a, int b) {
    print(a - b);
  }
}

class StrategyMultiply implements Strategy {
  @override
  void execute(int a, int b) {
    print(a * b);
  }
}

class StrategyDivide implements Strategy {
  @override
  void execute(int a, int b) {
    print(a / b);
  }
}

class Application {
  Strategy strategy;

  Application(this.strategy);

  void set(Strategy strategy) => this.strategy = strategy;

  void execute(int a, int b) => strategy.execute(a, b);
}

const a = 5;
const b = 125;

void main() {
  final app = Application(StrategyAdd());
  app.execute(a, b);

  app.set(StrategySubtract());
  app.execute(a, b);

  app.set(StrategyMultiply());
  app.execute(a, b);

  app.set(StrategyDivide());
  app.execute(a, b);
}
