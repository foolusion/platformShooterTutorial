part of platformShooter;

class TileType {
  static const int NONE = 0;
  static const int GROUND = 1;
  static const int AIR = 2;
  static const int DIRT = 3;
}

abstract class Tile {
  static const int TILE_WIDTH = 16;
  static const int TILE_HEIGHT = 16;
  int type;
  bool isSolid;
  Box box;
  draw();
}

class GroundTile extends Tile {
  Game g;
  GroundTile(this.g, Box box) {
    super.box = box;
    super.type = TileType.GROUND;
    super.isSolid = true;
  }
  
  draw() {
    g.ctx.save();
    g.ctx.translate(box.x, box.y);
    g.ctx.fillStyle = 'DarkSeaGreen';
    g.ctx.fillRect(0, 0, box.w, box.h);
    g.ctx.restore();
  }
}

class AirTile extends Tile {
  Game g;
  AirTile(this.g, Box box) {
    super.box = box;
    super.type = TileType.AIR;
    super.isSolid = false;
  }
  
  draw() {
    g.ctx.save();
    g.ctx.translate(box.x, box.y);
    g.ctx.fillStyle = 'DeepSkyBlue';
    g.ctx.fillRect(0, 0, box.w, box.h);
    g.ctx.restore();
  }
}

class DirtTile extends Tile {
  Game g;
  DirtTile(this.g, Box box) {
    super.box = box;
    super.type = TileType.DIRT;
    super.isSolid = true;
  }
  
  draw() {
    g.ctx.save();
    g.ctx.translate(box.x, box.y);
    g.ctx.fillStyle = 'BurlyWood';
    g.ctx.fillRect(0,0,box.w,box.h);
    g.ctx.restore();
  }
}