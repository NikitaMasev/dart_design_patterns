///Something like controller.
abstract class Mediator {
  void notify(Component component, String event);
}

///Base class for other components.
///Added functionality for other components
///to notify about events.
abstract class Component {
  final Mediator mediator;

  Component(this.mediator);

  void click() {
    mediator.notify(this, 'click base');
  }
}

class Checkbox extends Component {
  Checkbox(Mediator mediator) : super(mediator);

  void check() {
    mediator.notify(this, 'check');
  }
}

class AuthenticationMediator implements Mediator {
  @override
  void notify(Component component, String event) {
    switch (component.runtimeType.toString()) {
      case 'Checkbox':
        switch (event) {
          case 'click base':
            print('Handling click base of checkbox');
            break;
          case 'check':
            print('Handling check of checkbox');
            break;
        }
        break;
      case 'default':
        print('not handling');
        break;
    }
  }
}

void main() {
  final mediator = AuthenticationMediator();
  final checkbox = Checkbox(mediator);

  checkbox.click();
  checkbox.check();
}
