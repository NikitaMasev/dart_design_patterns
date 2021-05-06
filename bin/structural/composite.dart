abstract class Graphic {
  void render();
}

class Dot implements Graphic {
  @override
  void render() {
    print('Render Dot');
  }
}

class Circle implements Graphic {
  @override
  void render() {
    print('Render Circle');
  }
}

///Container, which composite graphics in one level branches of tree objects.
class ComplexGraphic implements Graphic {
  final List<Graphic> _graphics;

  ComplexGraphic(this._graphics);

  @override
  void render() {
    _graphics.forEach((graphic) => graphic.render());
  }
}

void main() {
  final complexOne = ComplexGraphic([Dot(), Dot(), Circle()]);
  final complexTwo = ComplexGraphic([complexOne, Circle(), Circle(), Circle()]);
  complexTwo.render();
}
