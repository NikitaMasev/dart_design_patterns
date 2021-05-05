import 'dart:io';

///Old AVI decoder, that used in all project.
abstract class AviDecoder {
  Future<void> aviDecode(String filePathSource, String filePathOut);
}

class AviDecoderImpl implements AviDecoder {
  @override
  Future<void> aviDecode(String filePathSource, filePathOut) {
    print('Start legacy avi decoding');
    print('Creating file origin');
    print('Decoding...');
    print('Saving decoded file');

    return Future.value();
  }
}

///Client code, that used legacy interface of AVI decoder.
class Application {
  final AviDecoder _aviDecoder;

  Application(this._aviDecoder);

  Future<File> decodeFileAndGet(
    String sourceFile,
    String outFile,
  ) async {
    await _aviDecoder.aviDecode(sourceFile, outFile);
    return File(outFile);
  }
}

///New AVI decoder with support multi core decoding.
abstract class AviMultiCoreDecoder {
  Future<void> decode(
      String filePathSource, String filePathOut, bool maxPriority);
}

class AviMultiCoreDecoderImpl implements AviMultiCoreDecoder {
  @override
  Future<void> decode(
      String filePathSource, String filePathOut, bool maxPriority) {
    print('Start new multi core avi decoding');
    print('Creating file origin');
    print('Decoding with max priority: $maxPriority');
    print('Saving decoded file');

    return Future.value();
  }
}

///Class that used old interface for compatibility with client code,
///but also used new implementation [AviMultiCoreDecoderImpl] for getting more
///performance of decoding.
class AviMultiCoreAdapter implements AviDecoder {
  final AviMultiCoreDecoder aviMultiCoreDecoder;
  final bool maxPriority;

  AviMultiCoreAdapter({
    required this.aviMultiCoreDecoder,
    required this.maxPriority,
  });

  @override
  Future<void> aviDecode(String filePathSource, String filePathOut) {
    return aviMultiCoreDecoder.decode(filePathSource, filePathOut, maxPriority);
  }
}

const PATH_SRC = 'D:/src.avi';
const PATH_OUT = 'D:/out.avi';

void main() {
  ///it was like that before
  final appLegacy = Application(AviDecoderImpl());
  appLegacy.decodeFileAndGet(PATH_SRC, PATH_OUT);

  print('------------------------------------');

  ///After integrating new AVIA decoder with adapter
  final adapterAviDecoder = AviMultiCoreAdapter(
    aviMultiCoreDecoder: AviMultiCoreDecoderImpl(),
    maxPriority: true,
  );

  final appMultiCore = Application(adapterAviDecoder);
  appMultiCore.decodeFileAndGet(PATH_SRC, PATH_OUT);
}
