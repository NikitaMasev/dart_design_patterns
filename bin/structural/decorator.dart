///Common interface of data source.
abstract class DataSource {
  Future<void> write(String data);

  Future<String> read();
}

///Base functionality.
class FileDataSource implements DataSource {
  final String fileName;

  FileDataSource(this.fileName);

  @override
  Future<String> read() {
    print('Read data.');
    return Future.value('simple data');
  }

  @override
  Future<void> write(String data) {
    print('Write data.');
    return Future.value();
  }
}

///Base class for other decorators.
class DataSourceDecorator implements DataSource {
  final DataSource _dataSource;

  DataSourceDecorator(this._dataSource);

  @override
  Future<String> read() {
    print('Log reading in base decorator.');
    return _dataSource.read();
  }

  @override
  Future<void> write(String data) {
    print('Log writing in base decorator.');
    return _dataSource.write(data);
  }
}

///Wrapper for compression/decompression data.
class CompressionDecorator extends DataSourceDecorator {
  CompressionDecorator(DataSource dataSource) : super(dataSource);

  @override
  Future<void> write(String data) {
    print('Compressing data before writing.');
    return super.write(data);
  }

  @override
  Future<String> read() async {
    final compressed = await super.read();
    print('Uncompressing data.');
    return Future.value(compressed);
  }
}

///Wrapper for encryption/decryption data
///and using parent compressing/decompressing function.
class EncryptionCompressionDecorator extends CompressionDecorator {
  EncryptionCompressionDecorator(DataSource dataSource) : super(dataSource);

  @override
  Future<void> write(String data) {
    print('Encrypting data before writing.');
    return super.write(data);
  }

  @override
  Future<String> read() async {
    final encrypted = await super.read();
    print('Decrypting data.');
    return Future.value(encrypted);
  }
}

///Client code, that used only interface of data source.
class Application {
  final DataSource _dataSource;

  Application(this._dataSource);

  Future<String> writeReadTest(String data) async {
    await _dataSource.write(data);
    return _dataSource.read();
  }
}

const dataFile = 'data.txt';
const data = 'afalsnfkoNAJBSJKBFNJKANSFHhawsfjkasfklasf';

Future<void> main() async {
  ///Simple example without decorators
  final simpleDataSource = FileDataSource(dataFile);

  final appSimple = Application(simpleDataSource);
  await appSimple.writeReadTest(data);

  print('----------------------------------------');

  ///Example with two wrapper of decorators.
  final appSecure = Application(EncryptionCompressionDecorator(simpleDataSource));
  await appSecure.writeReadTest(data);

}
