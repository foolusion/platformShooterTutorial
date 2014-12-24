part of platformShooter;

class World {
  Game g;
  final int TILES_PER_ROW = 40;
  List<Tile> world;
  
  World(this.g) {
    world = new List<Tile>(1200);
    math.Random rand = new math.Random(new DateTime.now().millisecondsSinceEpoch);
    for (int i = 0; i < world.length; i++) {
      Box b = new Box((i%TILES_PER_ROW)*Tile.TILE_WIDTH, (i~/TILES_PER_ROW)*Tile.TILE_HEIGHT, Tile.TILE_WIDTH, Tile.TILE_HEIGHT);
      switch (rand.nextInt(3)+1) {
        case TileType.GROUND:
          world[i] = new GroundTile(g, b);
          break;
        case TileType.AIR:
          world[i] = new AirTile(g, b);
          break;
        case TileType.DIRT:
          world[i] = new DirtTile(g, b);
          break;
      }
    }
  }
  
  List<Tile> neighbors(x, y) {
    int p = x + y * TILES_PER_ROW;
    List<Tile> n = new List<Tile>(8);
    n[0] = world[p-TILES_PER_ROW-1];
    n[1] = world[p-TILES_PER_ROW];
    n[2] = world[p-TILES_PER_ROW+1];
    n[3] = world[p-1];
    n[4] = world[p+1];
    n[5] = world[p+TILES_PER_ROW-1];
    n[6] = world[p+TILES_PER_ROW];
    n[7] = world[p+TILES_PER_ROW+1];
    return n;
  }
  
  draw() {
    for (Tile t in world) {
      t.draw();
    }
  }
}