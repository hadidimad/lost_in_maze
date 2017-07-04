class Bomb {
  float x, y, z, sx, sy, sz;
  float angle;
  float explodeDist;
  float speed;
  boolean seted;
  boolean exploded;
  float explodeR, maxExplodeR, explodeSpeed; 
  Bomb() {
    x=0;
    y=0;
    z=0;
    sx=0;
    sy=0;
    sz=0;
    angle=0;

    speed=17;
    seted=false;
    exploded=false;
    explodeR=0;
    maxExplodeR=50;
    explodeSpeed=1.6;
  }
  void setBomb(float inx, float iny, float inz, float inangle) {
    x=inx;
    y=iny;
    z=inz;
    sx=inx;
    sy=iny;
    sz=inz;
    angle=inangle;
    seted=true;
    exploded=false;
    explodeR=0;
  }
  void move(Player player, Maze maze) {
    if (seted) {
      if (!exploded) {
        if ((maze.get(floor(x/200), floor(z/200))) || (abs(x-player.x) < 30 ) && abs(z-player.z) < 30) {
          exploded=true;
        } else {
          x+=cos(angle)*speed;
          z+=sin(angle)*speed;
        }
      } else {
        if (explodeR < maxExplodeR) {
          explodeR+=explodeSpeed;
        } else {
          seted=false;
          if (player.x < x+explodeR+70 && player.x>x-explodeR-70 && player.z < z+explodeR+70 && player.z>z-explodeR-70) {
            exit();
            println("you Died", x, y, z);
          }
        }
      }
    }
  }
  void draw() {
    if (seted) {
      if (!exploded) {
        pushMatrix();
        translate(x, y, z);
        rotateY(-angle);
        fill(color(200, 100, 0));
        box(10, 5, 5);
        popMatrix();
      } else {
        pushMatrix();
        translate(x, y, z);
        fill(color(200, 100, 0));
        noStroke();
        sphere(explodeR);
        popMatrix();
      }
    }
  }
};