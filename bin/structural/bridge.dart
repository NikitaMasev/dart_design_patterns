abstract class Drawer {
  void drawCircle(int x, int y, int radius);
}

class TinyCircleDrawer implements Drawer {
  static const _radiusMultiplier = 1;

  @override
  void drawCircle(int x, int y, int radius) {
    print('DRAW Tiny Circle ${_radiusMultiplier * radius}');
  }
}

class BagelCircleDrawer implements Drawer {
  static const _radiusMultiplier = 20;

  @override
  void drawCircle(int x, int y, int radius) {
    print('DRAW Bagel Circle ${_radiusMultiplier * radius}');
  }
}

abstract class Shape {
  final Drawer drawer;

  Shape(this.drawer);

  void draw();

  void enlargeRadius(int multiplier);
}

class Circle extends Shape {
  final int x;
  final int y;
  int radius;

  Circle(
    this.x,
    this.y,
    this.radius,
    Drawer drawer,
  ) : super(drawer);

  @override
  void draw() {
    drawer.drawCircle(x, y, radius);
  }

  @override
  void enlargeRadius(int multiplier) {
    radius *= multiplier;
  }
}

void main() {
  final shapes = <Shape>[];
  shapes.addAll([
    Circle(2, 3, 23, TinyCircleDrawer()),
    Circle(10, 56, 150, BagelCircleDrawer()),
  ]);
  shapes.forEach((shape) => shape.draw());
}
