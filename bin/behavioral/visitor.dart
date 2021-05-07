abstract class Shape {
  void render();

  void accept(ExporterXml exporterXml);
}

class Dot implements Shape {
  @override
  void accept(ExporterXml exporterXml) {
    exporterXml.exportDot(this);
  }

  @override
  void render() {
    print('Render dot');
  }
}

class Circle implements Shape {
  @override
  void accept(ExporterXml exporterXml) {
    exporterXml.exportCircle(this);
  }

  @override
  void render() {
    print('Render dot');
  }
}

class Rectangle implements Shape {
  @override
  void accept(ExporterXml exporterXml) {
    exporterXml.exportRectangle(this);
  }

  @override
  void render() {
    print('Render dot');
  }
}

///A visitor interface
abstract class ExporterXml {
  void exportDot(Dot dot);

  void exportCircle(Circle circle);

  void exportRectangle(Rectangle rectangle);
}

class XmlExporterImpl implements ExporterXml {
  @override
  void exportCircle(Circle circle) {
    print('Export circle');
  }

  @override
  void exportDot(Dot dot) {
    print('Export dot');
  }

  @override
  void exportRectangle(Rectangle rectangle) {
    print('Export rectangle');
  }
}

void main() {
  final shapes = [
    Dot(),
    Circle(),
    Rectangle(),
  ];
  final xmlExporter = XmlExporterImpl();
  shapes.forEach((shape) => shape.accept(xmlExporter));
}
