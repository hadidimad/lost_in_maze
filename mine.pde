class Mine {
  float x;
  float y;
  float z;
  boolean seted=true;
  boolean exploded=false;
  float explodeSpeed=4.8;
  float explodeR=0;
  float maxExplodeR=250;
  Mine(float inx, float iny, float inz) {
    x=inx;
    y=iny;
    z=inz;
  }
  void explodeMine() {
    this.exploded=true;
  }
  void processMine(Player player) {
    if (seted) {
      if (exploded) {
        if (explodeR <= maxExplodeR) {
          explodeR+=explodeSpeed;
        } else {
          if (player.x < x+explodeR+100 && player.x>x-explodeR-100 && player.z < z+explodeR+100 && player.z>z-explodeR-100) {
            exit();
            println("you Died", x, y, z);
          }
          seted=false;
        }
      }
    }
  }
  void draw() {
    if (seted) {
      if (!exploded) {
        pushMatrix();
        translate(x, y, z);
        fill(0);
        box(20, 10, 20);
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