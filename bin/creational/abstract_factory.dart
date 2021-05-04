import 'dart:io';

abstract class Render {
  void render();
}

abstract class Button implements Render {}

class WindowsButton implements Button {
  @override
  void render() {
    print('Render Windows Button');
  }
}

class MacOsButton implements Button {
  @override
  void render() {
    print('Render MacOs Button');
  }
}

abstract class Checkbox implements Render {}

class WindowsCheckbox implements Checkbox {
  @override
  void render() {
    print('Render Windows Checkbox');
  }
}

class MacOsCheckbox implements Checkbox {
  @override
  void render() {
    print('Render MacOs Checkbox');
  }
}

///Abstract factory.
abstract class Gui {
  Button createButton();

  Checkbox createCheckbox();
}

class WindowsGui implements Gui {
  @override
  Button createButton() => WindowsButton();

  @override
  Checkbox createCheckbox() => WindowsCheckbox();
}

class MacOsGui implements Gui {
  @override
  Button createButton() => MacOsButton();

  @override
  Checkbox createCheckbox() => MacOsCheckbox();
}

class GuiConfigurator {
  static Gui createGui() {
    Gui gui;
    if (Platform.isWindows) {
      gui = WindowsGui();
    } else if (Platform.isMacOS) {
      gui = MacOsGui();
    } else {
      throw Exception('Unknown OS!');
    }

    return gui;
  }
}

void main() {
  Gui? gui;

  try {
    gui = GuiConfigurator.createGui();
  } on Exception catch (e) {
    print(e.toString());
  }

  final btn = gui?.createButton();
  final checkbox = gui?.createCheckbox();

  btn?.render();
  checkbox?.render();
}
