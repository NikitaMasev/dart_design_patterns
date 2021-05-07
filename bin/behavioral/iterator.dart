abstract class ProfileIteratorCreator {
  ProfileIterator create();
}

class Profiles implements ProfileIteratorCreator {
  final List<Profile> _profiles;

  Profiles(this._profiles);

  ///Factory method
  @override
  ProfileIterator create() {
    return ProfilesIterator(_profiles);
  }
}

class Profile {
  String? firstName;
  String? lastName;

  Profile(
    this.firstName,
    this.lastName,
  );

  Profile.empty();

  bool get isValid => firstName != null && lastName != null;

  @override
  String toString() {
    return 'Profile{firstName: $firstName, lastName: $lastName}';
  }
}

abstract class ProfileIterator {
  Profile next();

  bool hasMore();
}

class ProfilesIterator implements ProfileIterator {
  final List<Profile> _profiles;
  var _currentIndex = 0;

  ProfilesIterator(this._profiles);

  @override
  bool hasMore() {
    return _currentIndex < _profiles.length;
  }

  @override
  Profile next() {
    if (hasMore()) {
      final profile = _profiles[_currentIndex];
      _currentIndex++;
      return profile;
    }
    return Profile.empty();
  }
}

class ProfilesLogger {
  static void log(ProfileIterator profileIterator) {
    while (profileIterator.hasMore()) {
      print(profileIterator.next().toString());
    }
  }
}

void main() {
  final profiles = Profiles([
    Profile('John', 'Kek'),
    Profile('Alan', 'Bukark'),
    Profile('Yold', 'Sebastyan'),
  ]);

  ProfilesLogger.log(profiles.create());
}
