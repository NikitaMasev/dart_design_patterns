import 'dart:io';

///Example with abstract task converting video in other format.

class RawFile {}

class RawBitData {}

class FormatExtractor {
  final String fullPath;

  FormatExtractor(this.fullPath);
}

class VideoFile {
  final String fileName;

  VideoFile(this.fileName);
}

class CodecExtractor {
  final VideoFile videoFile;

  CodecExtractor(
    this.videoFile,
  );
}

class AudioExtractor {
  final CodecExtractor codecExtractor;

  AudioExtractor(this.codecExtractor);

  Future<RawFile> extract() => Future.value(RawFile());
}

class VideoExtractor {
  final CodecExtractor codecExtractor;

  VideoExtractor(this.codecExtractor);

  Future<RawFile> extract() => Future.value(RawFile());
}

class BitrateReader {
  final CodecExtractor codecExtractor;

  BitrateReader(this.codecExtractor);

  Future<RawBitData> read(RawFile rawFile, FormatExtractor formatExtractor) {
    return Future.value(RawBitData());
  }

  Future<RawBitData> convert(
      RawBitData buffer, FormatExtractor formatExtractor) {
    return Future.value(RawBitData());
  }
}

class VideoAudioMixer {
  final RawBitData video;
  final RawBitData audio;

  VideoAudioMixer(
    this.video,
    this.audio,
  );

  Future<File> saveFileAndGet(String fileDest) => Future.value(File(fileDest));
}

///Interface of Facade.
abstract class VideoConverter {
  Future<File> convert(String fileSrc, String fileDest);
}

///Encapsulation of some manipulation video
///and audio data for converting in other format.
class VideoConverterImpl implements VideoConverter {
  @override
  Future<File> convert(String fileSrc, String fileDest) async {
    final formatExtractorSrc = FormatExtractor(fileSrc);
    final formatExtractorDest = FormatExtractor(fileDest);

    final file = VideoFile(fileSrc);
    final codecExtractor = CodecExtractor(file);
    final bitrateReader = BitrateReader(codecExtractor);

    final audioRaw = await AudioExtractor(codecExtractor).extract();
    final videoRaw = await VideoExtractor(codecExtractor).extract();

    final convertedRawBitAudio = await bitrateReader.convert(
      await bitrateReader.read(audioRaw, formatExtractorSrc),
      formatExtractorDest,
    );
    final convertedRawBitVideo = await bitrateReader.convert(
      await bitrateReader.read(videoRaw, formatExtractorSrc),
      formatExtractorDest,
    );

    return VideoAudioMixer(convertedRawBitVideo, convertedRawBitAudio)
        .saveFileAndGet(fileDest);
  }
}

///Client code.
class Application {
  final VideoConverter _videoConverter;

  Application(this._videoConverter);

  Future<File> convertFile(String fileSrc, String fileDest) {
    return _videoConverter.convert(fileSrc, fileDest);
  }
}

const fileSrc = 'D:/video/summer.avi';
const fileDest = 'D:/video/summer.mpeg4';

Future<void> main() async {
  final app = Application(VideoConverterImpl());
  await app.convertFile(fileSrc, fileDest);
}
