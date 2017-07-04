class Player {
  float x, y, z;
  float px, py, pz;
  float angle;
  boolean life;
  float speed;
  class Mark {
    Mark() {
    }
    float x;
    float y;
  };
  Mark[] marks; 
  int marksNum=0;
  Player() {
    x=0;
    y=0;
    z=0;
    px=0;
    py=0;
    pz=0;
    angle=0;
    speed=10;
    life=true;
    marks=new Mark[0];
  }

  float getPX() {
    return x+cos(angle);
  }
  float getPY() {
    return y;
  }
  float getPZ() {
    return z+sin(angle);
  }

  void makeMark() {
    Mark tempMark=new Mark();
    tempMark.x=x+(200*cos(angle));
    tempMark.y=z+(200*sin(angle));
    marks=(Mark[])append(marks, tempMark);
    marksNum++;
  }
  void drawMarks() {
    int pfx=floor(this.x/200);
    int pfy=floor(this.z/200);
    for (int i=0; i<marksNum; i++) {
       if (abs(pfx-floor(marks[i].x/200))<=5 && abs(pfy-floor(marks[i].y/200)) <= 5) {
       pushMatrix();
       translate(marks[i].x, +100, marks[i].y);
       fill(200, 0, 100);
       box(30, 30, 30);
       popMatrix();
       }
    }
  }
  void deleteMarks(){
      marks=(Mark[])subset(marks,0,0);
      marksNum=0;
  }
  void moveForwardInMaze(Maze maze) {
    float nx=player.x+cos(angle)*speed;
    float nz=player.z+sin(angle)*speed;
    if (!maze.get(floor(nx/maze.Size), floor(nz/maze.Size))) {
      player.x=nx;
      player.z=nz;
    }
  }

  void moveBackwardInMaze(Maze maze) {
    float nx=player.x-cos(angle)*speed;
    float nz=player.z-sin(angle)*speed;
    if (!maze.get(floor(nx/maze.Size), floor(nz/maze.Size))) {
      player.x=nx;
      player.z=nz;
    }
  }

  void moveLeftInMaze(Maze maze) {
    float nx=player.x-cos(angle+radians(90))*speed;
    float nz=player.z-sin(angle+radians(90))*speed;
    if (!maze.get(floor(nx/maze.Size), floor(nz/maze.Size))) {
      player.x=nx;
      player.z=nz;
    }
  }
  void moveRightInMaze(Maze maze) {
    float nx=player.x-cos(angle-radians(90))*speed;
    float nz=player.z-sin(angle-radians(90))*speed;
    if (!maze.get(floor(nx/maze.Size), floor(nz/maze.Size))) {
      player.x=nx;
      player.z=nz;
    }
  }



  void drawPointer() {
    pushMatrix();
    fill(0);
    translate(x+(100*cos(angle)), y, z+(100*sin(angle)));
    rotateY(-angle);
    box(0.2, 0.2, 25);
    box(0.2, 25, 0.2);
    popMatrix();
  }
};