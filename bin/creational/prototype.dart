abstract class Cloneable {
  Shape clone();
}

abstract class Shape implements Cloneable {
  late final String color;
}

class Rectangle extends Shape {
  final int width;
  final int height;

  Rectangle(this.width, this.height, String color) {
    this.color = color;
  }

  @override
  Shape clone() => Rectangle(width, height, color);

  @override
  int get hashCode => width.hashCode ^ height.hashCode ^ color.hashCode;
}

void main() {
  Shape rectShape = Rectangle(20, 50, 'green');
  final cloneShape = rectShape.clone();

  print('Is the same objects: ${identical(rectShape, cloneShape)}');
  print('Is the equals by values: ${rectShape.hashCode == cloneShape.hashCode}');
}
