import 'dart:math';

class Video {
  final String data;

  Video(this.data);
}

abstract class YouTubeDownloader {
  Future<Video> video(int id);
}

class YouTubeDownloaderImpl implements YouTubeDownloader {
  @override
  Future<Video> video(int id) => _downloadVideo('query=$id');

  Future<Video> _downloadVideo(String query) =>
      Future.value(Video('${Random().nextInt(5000000)}$query'));
}

///Proxy with extra functionality - caching videos.
class CachedYouTubeDownloader implements YouTubeDownloader {
  final YouTubeDownloader _youTubeDownloader;
  final Map<int, Video> _cachedVideos = {};

  CachedYouTubeDownloader(this._youTubeDownloader);

  @override
  Future<Video> video(int id) async {
    if (_cachedVideos.containsKey(id)) {
      return Future.value(_cachedVideos[id]);
    } else {
      final video = await _youTubeDownloader.video(id);
      _cachedVideos.addAll({id: video});
      return Future.value(video);
    }
  }
}

///Client code.
class Application {
  final YouTubeDownloader _youTubeDownloader;

  Application(this._youTubeDownloader);

  Future<String> getDataFromVideo(int id) =>
      _youTubeDownloader.video(id).then((video) => video.data);
}

Future<void> main() async {
  ///Regular usage.
  final youTubeDownloader = YouTubeDownloaderImpl();

  final app = Application(youTubeDownloader);
  print(await app.getDataFromVideo(1));

  print('------------------------');

  ///Example with cached youtube downloader.
  final cachedApp = Application(CachedYouTubeDownloader(youTubeDownloader));
  print(await cachedApp.getDataFromVideo(2));
  print(await cachedApp.getDataFromVideo(2));
}
