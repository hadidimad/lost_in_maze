class Maze {
  boolean[][] maze;
  int MaxX;
  int MaxY;
  int Size;
  Maze(int maxx, int maxy, int size) {
    MaxY=maxy;
    MaxX=maxx;
    Size=size;
    maze=new boolean[MaxX][MaxY];
    for (int i=0; i<MaxX; i++) {
      for (int j=0; j<MaxY; j++) {
        maze[i][j]=false;
      }
    }
  }
  boolean get(int x, int y) {
    if (x >=0 && x<MaxX && y>=0 &&y<MaxY) {
      return maze[x][y];
    }
    return true;
  }

  void set(int x, int y, boolean value) {
    maze[x][y]=value;
  }
  void draw(int minx, int miny, int maxx, int maxy) {
    for (int i=minx; i<maxx; i++) {
      for (int j=miny; j<maxy; j++) {
        if (get(i,j)) {
          pushMatrix();
          fill(0, 100, 0);
          stroke(0);
          translate(i*Size+Size/2, 0, j*Size+Size/2);
          box(Size, 200, Size);
          popMatrix();
        }
      }
    }
  }
};