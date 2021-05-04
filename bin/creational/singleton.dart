abstract class Repository {}

class RepositoryImpl implements Repository {
  static Repository? _instance;
  final String _token;

  RepositoryImpl._(this._token);

  static Repository create(String token) =>
      _instance = _instance ?? RepositoryImpl._(token);
}

void main() {
  final repository = RepositoryImpl.create(':KASJNfjklnasljnfkljndlkfjjshjghj');
  final repositoryNew = RepositoryImpl.create('SFasfaskdngjdsfngjndsjkgjnbsd');

  print('Is the same objects: ${identical(repository, repositoryNew)}');
  print('Is the equals by values: ${repository.hashCode == repositoryNew.hashCode}');
}
