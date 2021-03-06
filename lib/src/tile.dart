part of tiled;

class Tile {
  // Tile IDs are 0-based, to conform with TMX documentation.
  int tileId;
  Tileset tileset;

  // Tile global IDs aren't 1-based, but start from "1" (0 being an "null tile").
  int gid;

  int width;
  int height;

  Map<String, String> properties = new Map();
  Image _image;

  Image get image {
    if (_image == null) {
      return tileset.image;
    }
    return _image;
  }

  // Optional X / Y locations for the tile.
  int x, y;
  int px, py;

  bool get isEmpty {
    return gid == 0;
  }

  Tile(this.tileId, this.tileset) {
    width = tileset.width;
    height = tileset.height;
    gid = tileId + tileset.firstgid;
    properties = tileset.tileProperties[gid];
    if (properties == null) {
      properties = {};
    }
    _image = tileset.tileImage[gid];
  }

  Tile.emptyTile() {
    gid = 0;
  }

  Rectangle computeDrawRect() {
    if (_image != null) {
      return new Rectangle(0, 0, _image.width, _image.height);
    }
    var tilesPerRow = tileset.image.width ~/ width;
    var row = tileId ~/ tilesPerRow;
    var column = tileId % tilesPerRow;
    var x = column * width;
    var y = row * height;
    return new Rectangle(x, y, width, height);
  }
}
