import 'dart:io';

import 'package:meta/meta.dart';

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

abstract class DialogRender implements Render {}

///Base class of factory.
class Dialog implements DialogRender {
  ///Factory method. Should be override in concrete class of Dialog.
  @protected
  Button createButton() {
    throw UnimplementedError();
  }

  @override
  void render() {
    final btn = createButton();
    btn.render();
  }
}

class WindowsDialog extends Dialog {
  @override
  Button createButton() => WindowsButton();
}

class MacOsDialog extends Dialog {
  @override
  Button createButton() => MacOsButton();
}

void main() {
  DialogRender dialogRender;

  if (Platform.isWindows) {
    dialogRender = WindowsDialog();
  } else if (Platform.isMacOS) {
    dialogRender = MacOsDialog();
  } else {
    throw Exception('Unknown OS!');
  }

  dialogRender.render();
}
