class Enemy {
  float x, y, z;
  float w, h, d;
  color  col;
  boolean life;
  BombHandler bomber=new BombHandler();

  class BombHandler {
    Bomb bombs[]=new Bomb[5];
    int time;
    boolean timeset=false;
    BombHandler() {
      for (int i=0; i<bombs.length; i++) {
        bombs[i]=new Bomb();
      }
    }
    void makeBomb(float inangle) {
      for (int i=0; i<bombs.length; i++) {
        if (!bombs[i].seted) {
          bombs[i].setBomb(x, y, z, inangle);
          break;
        }
      }
    }
    void makeBombInTime(float inangle, int timeout) {
      int nowTime=millis();
      if (!timeset) {
        time=nowTime;
        timeset=true;
      }
      if (nowTime - time > timeout && timeset) {
        makeBomb(inangle);
        timeset=false;
      }
    }
    void handleBombs(Player player, Maze maze) {
      for (int i=0; i<bombs.length; i++) {
        bombs[i].move(player, maze);
        bombs[i].draw();
      }
    }
  };
  Enemy(float inx, float iny, float inz, float inw, float inh, float ind, color incol) {
    x=inx;
    y=iny;
    z=inz;
    w=inw;
    h=inh;
    d=ind;
    col=incol;
    life=true;
  }
  void draw() {
    if (life) {
      pushMatrix();
      translate(x, y, z);
      fill(col);
      stroke(0);
      box(w, h, d);
      popMatrix();
    }
  }
};