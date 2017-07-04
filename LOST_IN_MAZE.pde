Player player;
Maze maze;
Level[] levels;
boolean isUp;
boolean isRight;
boolean isLeft;
boolean isDown;
boolean isarrLeft;
boolean isarrRight;
boolean playerisLive=true;
int thisLevel=0;
int MaxLevels;

void setup() {
  //size(640, 360, P3D);
  fullScreen(P3D);
  smooth();
  player=new Player();
  player.x=100;
  player.z=100;
  ////////////////////////////////////////////init levels
  JSONArray arr=loadJSONArray("levels.json");
  MaxLevels=arr.size();
  levels=new Level[arr.size()];
  for (int i=0; i<arr.size(); i++) {
    JSONObject obj=arr.getJSONObject(i);
    int Num=obj.getInt("Num");
    int ex=obj.getInt("Endx");
    int ey=obj.getInt("Endy");
    JSONArray enemy = obj.getJSONArray("Enemy");
    JSONArray thisMaze= obj.getJSONArray("Maze");
    JSONArray mines=obj.getJSONArray("Mine");
    levels[i]=new Level(Num, ex, ey,thisMaze.getJSONArray(0).size(),thisMaze.size(), enemy.size(),mines.size());
    for (int j=0; j<enemy.size(); j++) {
      levels[i].enemies[j]=new Enemy(enemy.getJSONObject(j).getInt("x")*200+100, 0, enemy.getJSONObject(j).getInt("y")*200+100, 30, 100, 30, color(100, 0, 0));
    }
    for(int j=0;j<mines.size();j++){
      levels[i].mine[j]=new Mine(mines.getJSONObject(j).getInt("x")*200+100, 100, mines.getJSONObject(j).getInt("y")*200+100);
    }
    for (int j=0; j<thisMaze.size(); j++) {
      JSONArray row=thisMaze.getJSONArray(j);
      for (int k=0; k<row.size(); k++) {
        if (row.getInt(k) == 1) {
          levels[i].maze.set(j, k, true);
        } else if (row.getInt(k) == 0) {
          levels[i].maze.set(j, k, false);
        }
      }
    }
  }
  ////////////////////////////////////////////
}

void draw() {
  background(100, 100, 100);
  if (playerisLive) {
    moveControl(levels[thisLevel].maze);
    camera(player.x, player.y, player.z, player.getPX(), player.getPY(), player.getPZ(), 0, 1, 0);
    //println(player.x, player.y, player.z, player.angle);
    player.drawPointer();
    player.drawMarks();
    levels[thisLevel].maze.draw(floor(player.x/200)-7, floor(player.z/200)-7, floor(player.x/200)+7, floor(player.z/200)+7);
    levels[thisLevel].drawGoldBox(floor(player.x/200),floor(player.z/200));
    levels[thisLevel].drawEnemies();
    levels[thisLevel].handleEnemies(player);
    levels[thisLevel].handleMines(player);
    levels[thisLevel].drawMines(player);
    if (floor(player.x/200)==levels[thisLevel].endx &&floor(player.z/200)==levels[thisLevel].endy) {
      thisLevel++;
      player.x=100;
      player.z=100;
      player.deleteMarks();
      if (thisLevel>=MaxLevels) {
        exit();
      }
    }
  }
}
float a;
void moveControl(Maze maze) {
  if (isLeft) {
    player.moveLeftInMaze(maze);
  } 
  if (isRight) {
    player.moveRightInMaze(maze);
  }
  if (isUp) {
    player.moveForwardInMaze(maze);
  }
  if ( isDown) {
    player.moveBackwardInMaze(maze);
  }
  if (isarrLeft) {
    player.angle-=0.04;
  } else if (isarrRight) {
    player.angle+=0.04;
  }
}
void keyPressed() {
  setMove(key, keyCode, true);
  if(key == 'e'){
    player.makeMark();
  }
}

void keyReleased() {
  setMove(key, keyCode, false);
}

boolean setMove(int k, int C, boolean b) {
  if (C == LEFT) {
    isarrLeft=b;
  }
  if ( C== RIGHT) {
    isarrRight=b;
  }
  switch (k) {
  case 'w':
    return isUp = b;

  case 's':
    return isDown = b;

  case 'a':
    return isLeft = b;

  case 'd':
    return isRight = b;

  default:
    return b;
  }
}