class AvatarCircle {
  String? _text;
  int? _radius;

  void setText(String? text) {
    _text = text;
  }

  void setRadius(int? radius) {
    _radius = radius;
  }

  SnapshotAvatarCircle createSnapshot() => SnapshotAvatarCircle(
        text: _text,
        radius: _radius,
        avatarCircle: this,
      );

  @override
  String toString() {
    return 'AvatarCircle{_text: $_text, _radius: $_radius}';
  }
}

class SnapshotAvatarCircle {
  final AvatarCircle _avatarCircle;
  String? text;
  int? radius;

  SnapshotAvatarCircle({
    required this.text,
    required this.radius,
    required AvatarCircle avatarCircle,
  }) : _avatarCircle = avatarCircle;

  void restore() {
    _avatarCircle.setText(text);
    _avatarCircle.setRadius(radius);
  }
}

void main() {
  final avatar = AvatarCircle()
      ..setRadius(10)
      ..setText('test101');

  print('Before changing ${avatar.toString()}');

  final snapshot = avatar.createSnapshot();

  avatar.setText('test560');

  print('After changing ${avatar.toString()}');

  snapshot.restore();

  print('Restore ${avatar.toString()}');
}