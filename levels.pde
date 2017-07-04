class Level {
  int Num;
  Maze maze;
  Enemy[] enemies;
  int numEnemy;
  int endx;
  int endy;
  Mine[] mine;
  int MNum;
  Level(int innum, int ex, int ey, int MmaxX, int MmaxY, int enmNum, int mineNum) {
    Num=innum;
    endx=ex;
    endy=ey;
    maze=new Maze(MmaxX, MmaxY, 200);
    enemies=new Enemy[enmNum];
    mine=new Mine[mineNum];
    numEnemy=enmNum;
    MNum=mineNum;
  }

  void drawGoldBox(int pfx, int pfy) {
    if (abs(pfx-endx)<=5 && abs(pfy-endy) <= 5) {
      pushMatrix();
      translate(endx*200+100, 0, endy*200+100);
      fill(0, 200, 300);
      box(30, 30, 30);
      popMatrix();
    }
  }
  void handleEnemies(Player player) {
    int pfx=floor(player.x/200);
    int pfy=floor(player.z/200);
    for (int i=0; i<numEnemy; i++) {
      if (abs(pfx-floor(enemies[i].x/200))<=5 && abs(pfy-floor(enemies[i].z/200)) <= 5) {
        //enemies[i].bomber.makeBomb(atan((enemies[i].z-player.z)/(enemies[i].x-player.x))+radians(180));
        enemies[i].bomber.makeBombInTime(atan2((enemies[i].z-player.z), (enemies[i].x-player.x))+radians(180), 500);
        enemies[i].bomber.handleBombs(player, this.maze);
      }
    }
  }
  void drawEnemies() {
    int pfx=floor(player.x/200);
    int pfy=floor(player.z/200);
    for (int i=0; i<numEnemy; i++) {
      if (abs(pfx-floor(enemies[i].x/200))<=5 && abs(pfy-floor(enemies[i].z/200)) <= 5) {
        enemies[i].draw();
      }
    }
  }
  void handleMines(Player player) {
    int pfx=floor(player.x/200);
    int pfy=floor(player.z/200);
    for (int i=0; i<MNum; i++) {
      if (abs(pfx-floor(mine[i].x/200))==0 && abs(pfy-floor(mine[i].z/200)) == 0) {
        mine[i].explodeMine();
      }
       mine[i].processMine(player);
    }
  }
  void drawMines(Player player) {
    int pfx=floor(player.x/200);
    int pfy=floor(player.z/200);
    for (int i=0; i<MNum; i++) {
      if (abs(pfx-floor(mine[i].x/200))<=4 && abs(pfy-floor(mine[i].z/200)) <= 4) {
        mine[i].draw();
      }
    }
  }
};