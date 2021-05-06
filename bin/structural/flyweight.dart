import 'dart:math';

///An abstract class of bitmap, which represents texture.
///This is a simplified class.
///In real life it may be something big file.
class Bitmap {
  final int value;
  final String code;
  final String codeValue;

  Bitmap({
    required this.value,
    required this.code,
    required this.codeValue,
  });
}

///Some class, that needed to optimize by [texture].
///[texture] is often repeated after analytics.
class Tree {
  final double x;
  final double y;
  final Bitmap texture;

  const Tree({
    required this.x,
    required this.y,
    required this.texture,
  });
}

///Factory of [Tree], that encapsulate repeated texture values.
class TreeFactory {
  static final _cached = <Bitmap>[];
  //static Bitmap? cachedOne;

/*  static Tree getTree(
    double x,
    double y,
    int valueBitmap,
    String code,
    String codeValue,
  ) {
    if (cachedOne == null) {
      final texture = Bitmap(
        value: valueBitmap,
        code: code,
        codeValue: codeValue,
      );
      cachedOne = texture;

      return Tree(
        x: x,
        y: y,
        texture: texture,
      );
    } else if (cachedOne?.value==valueBitmap && cachedOne?.code == code && cachedOne?.codeValue == codeValue) {
      print('CACHED RETURNED');
      return Tree(
        x: x,
        y: y,
        texture: cachedOne!,
      );
    } else {
      final texture = Bitmap(
        value: valueBitmap,
        code: code,
        codeValue: codeValue,
      );

      return Tree(
        x: x,
        y: y,
        texture: texture,
      );
    }
  }*/

static Tree getTree(
    double x,
    double y,
    int valueBitmap,
    String code,
    String codeValue,
  ) {
    final bitMap = _cached.firstWhere(
      (texture)=> texture.value == valueBitmap &&
          texture.code == code &&
          texture.codeValue == codeValue,
      orElse: () {
        final texture = Bitmap(
          value: valueBitmap,
          code: code,
          codeValue: codeValue,
        );
        _cached.add(texture);
        return texture;
      },
    );

    return Tree(
      x: x,
      y: y,
      texture: bitMap,
    );
  }
}

const countTree = 10000;
const analyticsValueCountRepeatedTextures = 5000;
const randomLimit = 50000;

int getTextureValue() => Random().nextInt(randomLimit);

String getTextureCode() => '${Random().nextInt(randomLimit)}'
    '${Random().nextInt(randomLimit)}${Random().nextInt(randomLimit)}';

String getTextureCodeValue() =>
    '${Random().nextInt(randomLimit)}${Random().nextInt(randomLimit)}'
    '${Random().nextInt(randomLimit)}${Random().nextInt(randomLimit)}'
    '${Random().nextInt(randomLimit)}${Random().nextInt(randomLimit)}';

///NOTE: With this simple repeated [Bitmap] we aren't see any benefits.
///Because cached collection also consume memory and contain [Bitmap]'s,
///that non repeated int all program.
///More benefits can be if we should use LRU cache.
Future<void> main() async {

  final repeatedTextureValue = getTextureValue();
  final repeatedTextureCode = getTextureCode();
  final repeatedTextureCodeValue = getTextureCodeValue();

/*  final treesNonOptimized = <Tree>[];
  final textures = <Bitmap>[];

  for (var i = 0; i < COUNT_TREE; i++) {
    textures.add(
      Bitmap(
        value: i <= ANALYTICS_VALUE_COUNT_REPEATED_TEXTURES
            ? repeatedTextureValue
            : getTextureValue(),
        code: i <= ANALYTICS_VALUE_COUNT_REPEATED_TEXTURES
            ? repeatedTextureCode
            : getTextureCode(),
        codeValue: i <= ANALYTICS_VALUE_COUNT_REPEATED_TEXTURES
            ? repeatedTextureCodeValue
            : getTextureCodeValue(),
      ),
    );
  }

  for (var i = 0; i < COUNT_TREE; i++) {
    treesNonOptimized.add(
      Tree(
        x: Random().nextDouble(),
        y: Random().nextDouble(),
        texture: textures[i],
      ),
    );
  }*/

  final treesOptimized = <Tree>[];

  for (var i = 0; i < countTree; i++) {
    treesOptimized.add(
      TreeFactory.getTree(
        Random().nextDouble(),
        Random().nextDouble(),
        i <= analyticsValueCountRepeatedTextures
            ? repeatedTextureValue
            : getTextureValue(),
        i <= analyticsValueCountRepeatedTextures
            ? repeatedTextureCode
            : getTextureCode(),
        i <= analyticsValueCountRepeatedTextures
            ? repeatedTextureCodeValue
            : getTextureCodeValue(),
      ),
    );
  }

  await Future.delayed(const Duration(seconds: 30));
}
