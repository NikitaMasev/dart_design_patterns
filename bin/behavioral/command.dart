import 'dart:math';

abstract class CommandSquare {
  double execute();

  void info(double val) {
    print('${runtimeType.toString()} executed. Result: $val');
  }
}

class SquareCommand extends CommandSquare {
  final double side;

  SquareCommand(this.side);

  @override
  double execute() {
    final result = side * side;
    info(result);
    return result;
  }
}

class CircleCommand extends CommandSquare {
  final double radius;

  CircleCommand(this.radius);

  @override
  double execute() {
    final result = pi * radius;
    info(result);
    return result;
  }
}

class Application {
  final List<CommandSquare> _commands;

  Application(this._commands);

  void start() {
    _commands.forEach((command) => command.execute());
  }
}

void main() {
  final app = Application([
    SquareCommand(23.5),
    CircleCommand(894.459),
  ]);

  app.start();
}
