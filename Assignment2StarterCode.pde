/*
    DIT OOP Assignment 2 Starter Code
 =================================
 
 Loads player properties from an xml file
 See: https://github.com/skooter500/DT228-OOP 
 
 ======================================
 Name :       Salim Uddin
 Student No:  C12450132
 =====================================
 */
import ddf.minim.*; // import library for sound 
Minim minim; // provides library of classes that work with sound files

//  Set the audio players 
AudioPlayer Crash_Sound;
AudioPlayer horse_Sound;
AudioPlayer repair_Sound;
AudioPlayer explosion_Sound;
AudioPlayer Background_Sound;

//  Create an arraylist of game object
ArrayList<GameObject> allobjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[526];

// Declared variables
float game_speed = 1.1f, slowdown = 1.0f;
int PlayerPlaying  = 0;
int PlayerDead =0;
int gap =325;
int x = 155;

PImage imgStart, imgOver, imgInstruction, bomb;
PFont font1, font2;
int Cent_X, Cent_Y;
int score =0;

String game_state = "MainScreen";
float max_speed = 20, min_speed = 5;


boolean sketchFullScreen()
{
  return true;
}


void setup()
{
  size(700, 700);
  Cent_X = width / 2; 
  Cent_Y = height / 2;

  //  Load the images
  imgStart = loadImage("SpyHunter.jpg");
  imgOver= loadImage("GameOver.png");
  bomb= loadImage("bomb1.jpg");
  imgInstruction= loadImage("instruction.png");

  //  Create fonts
  font1=createFont("Britannic Bold", 25);
  font2=createFont("Britannic", 18);

  //  Load the audio
  minim = new Minim(this);
  Crash_Sound=minim.loadFile("crash.wav");
  horse_Sound=minim.loadFile("horse.wav");
  repair_Sound=minim.loadFile("repair.wav");
  explosion_Sound=minim.loadFile("explosion.wav");
  Background_Sound= minim.loadFile("traffic_bg.wav");


  allobjects.add(new Background(-height, width, height*2, "road.jpg")); // add the background

  setUpPlayerControllers();  


  for (int i = 0; i < 6; i++) {// loop to add the oncoming cars
    allobjects.add(new Car("Bad_Car" + (i+1) + ".png"));
  }

  allobjects.add(new Extra_Health("extralive.png"));// loop to add extra health point

  allobjects.add(new Horse("horse.png")); // loop to add the oncoming horses
}







void draw()
{


  if (game_state == "MainScreen") // Draw Game Main Scren 
  {
    image(imgStart, 0, 0, width, height);

    textFont(font1);
    fill(255, 0, 0);
    text("Insert COIN and Press START to Play the Game", Cent_X-260, Cent_Y+220);

    for (GameObject eachobject : allobjects)
    {

      if (eachobject instanceof Player) {
        eachobject.update();
        Player p = (Player) eachobject;

        if (p.index == 1) {
          fill(255, 128, 0);
          text("Player 1 Credit: ", Cent_X-320, Cent_Y-170);
          text(p.coin, Cent_X-130, Cent_Y-170);
        } else if (p.index == 2) {
          fill(51, 255, 51);
          text("Player 2 Credit: ", Cent_X+100, Cent_Y-170);
          text(p.coin, Cent_X+290, Cent_Y-170);
        }
        if (p.started) {
          game_state = "InstructionScreen";
        }
      }//end if eachobject
    }//end for loop
  } // End first screen.

  else if (game_state == "InstructionScreen") { // Draw Game Main Scren

    background(255, 204, 153);
    image(imgInstruction, Cent_X-350, Cent_Y-340);
    textFont(font1);
    fill(255, 0, 0);
    text("Player Instructions", Cent_X-120, Cent_Y-190);
    textFont(font2);
    fill(0);
    text("- Use JoyStick to Drive", Cent_X-280, Cent_Y-150);
    text("- Use Button1 to Shoot", Cent_X-280, Cent_Y-120);
    text("- Use Button2 to Throw a Bomb", Cent_X-280, Cent_Y-90);

    textFont(font1);
    fill(255, 0, 0);
    text("Goals", Cent_X-60, Cent_Y-40);
    textFont(font2);
    fill(0);
    text("- Shoot or Bomb oncomming cars ", Cent_X-280, Cent_Y);
    text("- Shoot or Bomb oncomming horses ", Cent_X-280, Cent_Y+30);
    text("- Get the tool symbol to increase health ", Cent_X-280, Cent_Y+60);

    textFont(font1);
    fill(255, 0, 0);
    text("Scoring / Health Info", Cent_X-100, Cent_Y+100);
    textFont(font2);
    fill(0);
    text("- Default Health is 50 and Maximun Health is 50 ", Cent_X-280, Cent_Y+140);
    text("- 10 points will be taken if you get hit by an oncoming car", Cent_X-280, Cent_Y+170);
    text("- 20 points will be taken if you get hit by an oncoming horse", Cent_X-280, Cent_Y+200);
    text("- 5 points will be added to your score if you shoot oncoming car", Cent_X-280, Cent_Y+230);
    text("- 10 points will be added to your score if you shoot oncoming horse", Cent_X-280, Cent_Y+260);
    text("- 10 points will be added to your score if you bomb oncoming car", Cent_X-280, Cent_Y+290);
    text("- 10 points will be added to your score if you bomb oncoming horse", Cent_X-280, Cent_Y+320);
    fill(0, 0, 255);
    text("Click Here to Skip Instruction", Cent_X+60, Cent_Y-40);



    if (mousePressed) {
      //if((mouseX > 230 && mouseX <370)&&(mouseY > 480 && mouseY < 500)){
      if ((mouseX > Cent_X+50 && mouseX <Cent_X+300)&&(mouseY > Cent_Y-60 && mouseY < Cent_Y-30)) {
        game_state = "playing";
      }
    }
  } //end InstructionScreen

  else if (game_state == "playing") // Draw Game Play screen
  {

    if (!Background_Sound.isPlaying()) { // check the background sound  
      Background_Sound.play(); // play the background sound 
      Background_Sound.rewind(); // when background sound is finish, re-play the sound
    }


    for (int i = 0; i < allobjects.size (); i++) { //loop through the all objects

      // its it's a background
      if (allobjects.get(i) instanceof Background) {
        allobjects.get(i).speed = game_speed;
      } // end if Background.


      // if it's a car
      if (allobjects.get(i) instanceof Car) {
        Car car = (Car) allobjects.get(i);
        respawnCars(car);
        for (int j = 0; j < allobjects.size (); j++) {
          if (j != i) {
            if (allobjects.get(j) instanceof Player) {
              Player player = (Player) allobjects.get(j);
              carCrashesIntoPlayer(car, player);
            }
          }
        }
      } // end if Car.



      // if it's a horse
      if (allobjects.get(i) instanceof Horse) {
        Horse horse = (Horse) allobjects.get(i);
        respawnHorse(horse);
        for (int j = 0; j < allobjects.size (); j++) {
          if (j != i) {
            if (allobjects.get(j) instanceof Player) {
              Player player = (Player) allobjects.get(j);
              HorseCrashesIntoPlayer(horse, player);
            }
          }
        }
      } //end if horse.



      // if its an extra health
      if ( allobjects.get(i) instanceof Extra_Health) {
        Extra_Health eh = (Extra_Health) allobjects.get(i);
        respawnExtraHealth(eh);

        for (int j = 0; j < allobjects.size (); j++) {
          if (j != i) {
            if (allobjects.get(j) instanceof Player) {
              Player p = (Player) allobjects.get(j);
              PLayerGetsExtraHealth(eh, p);
            }
          }
        }
      }//end if extra health




      // if it's a player
      if (allobjects.get(i) instanceof Player) {
        Player p = (Player) allobjects.get(i);
        PlayersInfo(p);//call the PlayersInfo mehthod and pass the player
        inBounds(p);//call the inBounds mehthod and pass the player
        PlayerScoreCheck(p); //call the PlayerScoreCheck mehthod and pass the player
        
        if (p.started && p.pos.y < 400) {
          if (game_speed < max_speed)
          {
            game_speed += 0.1;
          }
        } else if (p.started && p.pos.y > 500) {
          if (game_speed > min_speed)
          {
            game_speed -= 0.1;
          }
        }

        for (int j = 0; j < allobjects.size (); j++) {

          if (allobjects.get(j) instanceof Player) {
            Player p2 = (Player) allobjects.get(j);
            //PlayerCrashesIntoPlayer(p, p2);
          }

          if ( allobjects.get(j) instanceof Car) {
            Car c = (Car) allobjects.get(j);
            PlayerShootCar(p, c); //call the PlayerShootCar mehthod and pass the player and the car
          }

          if ( allobjects.get(j) instanceof Horse) {
            Horse h = (Horse) allobjects.get(j);
            PlayerShootHorse(p, h); //call the PlayerShootHorse mehthod and pass the player and the Horse
          }

          if ( allobjects.get(j) instanceof Car) {
            Car c = (Car) allobjects.get(j);
            PlayerBombCar(p, c); //call the PlayerBombCar mehthod and pass the player and the car
          }

          if ( allobjects.get(j) instanceof Horse) {
            Horse h = (Horse) allobjects.get(j);
            PlayerBombHorse(p, h); //call the PlayerBombHorse mehthod and pass the player and the horse
          }
        }
      } // Player.




      allobjects.get(i).update(); //update all objects
      allobjects.get(i).display(); //display all objects

      if (allobjects.get(i).alive == false) { //if all objects alive is false
        allobjects.remove(allobjects.get(i)); // than remove it from the array list
      }
    } // End all objects for loop.

    if (PlayerPlaying == PlayerDead) {
      game_state="GameOver";
    }
  } // End playing.

  else if (game_state == "GameOver") { //if gamestate is equal to gameover than draw the game over screen

    Background_Sound.pause(); //stop the background sound
    image(imgOver, 0, 0, width, height);
    textFont(font1);
    fill(255, 0, 0);
    text("Game Over", Cent_X-50, Cent_Y-190);


    for (int i = 0; i < allobjects.size (); i++) {

      if (allobjects.get(i) instanceof Player) {
        Player p = (Player) allobjects.get(i);

        if (p.index == 1 ) {//display player 1 score when game is over
          textFont(font1);
          fill(255, 128, 0);
          text("Player 1: ", Cent_X-330, Cent_Y-150);
          text("Score: " + p.score, Cent_X-330, Cent_Y-110);
        }
        if (p.index == 2 ) { //display player 2 score when game is over
          textFont(font1);
          fill(0, 255, 0);
          text("Player 2: ", Cent_X+200, Cent_Y-150);
          text("Score: " + p.score, Cent_X+200, Cent_Y-110);
        }
        if (mousePressed) {
          if ((mouseX > Cent_X-200 && mouseX <Cent_X+210)&&(mouseY > Cent_Y+200 && mouseY < Cent_Y+230)) {
            //reset the player variables
            p.coin = 0;
            p.started=false;
            p.score=0;
            p.health=50;
            game_speed = 1.1f;
            p.pos.x = x;
            p.pos.y = Cent_Y +190;
            //x += gap;
          }

          game_state = "MainScreen";//bring the player back to main screen to insert coin and play agian
        }
      }
    }
    fill(0, 0, 255);
    text("Click Here to go back to Main Screen", Cent_X-200, Cent_Y+220);
  }
} // End draw.

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  //int gap =325;
  //int x = 155;
  for (int i = 0; i < children.length; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(
    i + 1
      , "Car_" + (i+1) + ".png"
      , playerXML);
    p.pos.x = x;
    p.pos.y = Cent_Y +190;
    allobjects.add(p);
    x += gap;
  }
}//end setUpPlayerControllers




void inBounds(GameObject player)//methods to check the player position 
{
  if (player.pos.x > ((width/4)*3) -player.w)
  {
    player.pos.x = ((width/4)*3) -player.w;
  } else if (player.pos.x < width/4)
  {
    player.pos.x = width/4;
  }

  if (player.pos.y < Cent_Y -110)
  {
    player.pos.y = Cent_Y -110;
  } else if (player.pos.y > Cent_Y +190)
  {
    player.pos.y = Cent_Y +190;
  }
}//end inBounds




void respawnCars(GameObject car) { //method to repawn cars
  if (car.pos.y > height) {
    car.alive = false;
    int rnd = (int) random(1, 5);
    allobjects.add(new Car("Bad_Car" + rnd + ".png"));
  }
}//end respawnCars

void respawnExtraHealth(GameObject eh) { //method to repawn extra health
  if (eh.pos.y > height) {
    eh.alive = false;
    allobjects.add(new Extra_Health("extralive.png"));
  }
}//end respawnExtraHealth

void respawnHorse(GameObject horse) { //method to repawn horses
  if (horse.pos.y > height) {
    horse.alive = false;
    allobjects.add(new Horse("horse.png"));
  }
}//end respawnExtraHealth



void carCrashesIntoPlayer(Car c, Player p) { // method to check cars collision with player
  if (p.started) {
    if (c.pos.y + c.h > p.pos.y && c.pos.y < p.pos.y + p.h && c.pos.x + c.w > p.pos.x && c.pos.x < p.pos.x+p.w) {
      Crash_Sound.rewind();
      Crash_Sound.play();
      c.alive = false;
      int rnd = (int) random(1, 6);
      allobjects.add(new Car("Bad_Car" + rnd + ".png"));
      p.health-=10;
    }
  }
}//end carCrashesIntoPlayer


void PlayerShootCar(Player p, Car c) { // method to check player shoot car
  if (p.started) {
    for (int i =0; i < p.bullets.size (); i++) {
      if (p.bullets.get(i).pos.y < c.pos.y + c.h &&
        p.bullets.get(i).pos.y + p.bullets.get(i).h > c.pos.y &&
        p.bullets.get(i).pos.x + p.bullets.get(i).w > c.pos.x &&
        p.bullets.get(i).pos.x < c.pos.x + c.w) {
        p.bullets.get(i).alive = false;
        p.score +=5;
        c.alive = false;
        int rnd = (int) random(1, 6);
        allobjects.add(new Car("Bad_Car" + rnd + ".png"));
      }
    }
  }
}//end PlayerShootCar

void PlayerShootHorse(Player p, Horse h) { // method to check player shoot horse
  if (p.started) {
    for (int i =0; i < p.bullets.size (); i++) {
      if (p.bullets.get(i).pos.y < h.pos.y + h.h &&
        p.bullets.get(i).pos.y + p.bullets.get(i).h > h.pos.y &&
        p.bullets.get(i).pos.x + p.bullets.get(i).w > h.pos.x &&
        p.bullets.get(i).pos.x < h.pos.x + h.w) {
        horse_Sound.rewind();
        horse_Sound.play();
        p.bullets.get(i).alive = false;
        p.score +=10;
        h.alive = false;
        allobjects.add(new Horse("horse.png"));
      }
    }
  }
}//end PlayerShootHorse

void PlayerBombCar(Player p, Car c) { // method to check player bomb car
  if (p.started) {
    for (int i =0; i < p.bombs.size (); i++) {
      if (p.bombs.get(i).pos.y < c.pos.y + c.h &&
        p.bombs.get(i).pos.y + p.bombs.get(i).h > c.pos.y &&
        p.bombs.get(i).pos.x + p.bombs.get(i).w > c.pos.x &&
        p.bombs.get(i).pos.x < c.pos.x + c.w) {
        explosion_Sound.rewind();
        explosion_Sound.play();
        p.bombs.get(i).alive = false;
        //image(bomb, c.pos.x, c.pos.y, c.w, c.h);
        p.score +=10;
        c.alive = false;
        int rnd = (int) random(1, 6);
        allobjects.add(new Car("Bad_Car" + rnd + ".png"));
      }
    }
  }
}//end PlayerBombCar

void PlayerBombHorse(Player p, Horse h) { // method to check player bomb horse
  if (p.started) {
    for (int i =0; i < p.bombs.size (); i++) {
      if (p.bombs.get(i).pos.y < h.pos.y + h.h &&
        p.bombs.get(i).pos.y + p.bombs.get(i).h > h.pos.y &&
        p.bombs.get(i).pos.x + p.bombs.get(i).w > h.pos.x &&
        p.bombs.get(i).pos.x < h.pos.x + h.w) {
        explosion_Sound.rewind();
        explosion_Sound.play();
        //image(bomb, h.pos.x, h.pos.y, h.w, h.h);
        p.bombs.get(i).alive = false;
        p.score +=15;
        h.alive = false;
        allobjects.add(new Horse("horse.png"));
      }
    }
  }
}//end PlaPlayerBombHorse


void HorseCrashesIntoPlayer(Horse h, Player p) { // method to check horse collision with player
  if (p.started) {
    if (h.pos.y + h.h > p.pos.y && h.pos.y < p.pos.y + p.h && h.pos.x + h.w > p.pos.x && h.pos.x < p.pos.x+p.w) {
      horse_Sound.rewind();
      horse_Sound.play();
      h.alive = false;
      allobjects.add(new Horse("horse.png"));
      p.health-=20;
    }
  }
}//HorseCrashesIntoPlayer

void PLayerGetsExtraHealth(Extra_Health eh, Player p ) { // method to check player get the extra health
  if (p.started) {
    if (eh.pos.y + eh.h > p.pos.y && eh.pos.y < p.pos.y + p.h && eh.pos.x + eh.w > p.pos.x && eh.pos.x < p.pos.x+p.w) {
      repair_Sound.rewind();
      repair_Sound.play();
      eh.alive = false;
      allobjects.add(new Extra_Health("extralive.png"));

      if (p.health < 50) {
        p.health +=10;
      }
    }
  }
}//end PLayerGetsExtraHealth

/*
void PlayerCrashesIntoPlayer(Player p1, Player p2) {
 if (p1.started && p2.started) {
 if (p1.pos.y < p2.pos.y + p2.h &&
 p1.pos.y + p1.h > p2.pos.y &&
 p1.pos.x + p1.w > p2.pos.x &&
 p1.pos.x < p2.pos.x + p2.w) {
 
 p1.speed = -p1.speed;
 p2.speed = -p2.speed;
 println("player crashed");
 }
 }
 }//end PlayerCrashesIntoPlayer
 */

void PlayersInfo(Player p) { //method to show player score , health and speed

  if (p.index == 1 && p.started) {
    textFont(font1);
    fill(255, 128, 0);
    text("Player 1: ", Cent_X-330, Cent_Y-250);
    text("Score: " + p.score, Cent_X-330, Cent_Y-210);
    //text(p1.score, Cent_X-330, Cent_Y-210);
    text("Health: " + p.health, Cent_X-330, Cent_Y-170);
    text("Speed: " + ( ((int) game_speed * p.pos.y)/100 ) + "kmp", Cent_X-330, Cent_Y-130);
  }
  if (p.index == 2 && p.started) {
    textFont(font1);
    fill(0, 255, 0);
    text("Player 2: ", Cent_X+200, Cent_Y-250);
    text("Score: " + p.score, Cent_X+200, Cent_Y-210);
    text("Health: "+ p.health, Cent_X+200, Cent_Y-170);
    text("Speed: "+ ( ((int) game_speed * p.pos.y)/100 ) + "kmp", Cent_X+180, Cent_Y-130);
  }
}//end PlayersInfo



void PlayerScoreCheck(Player p) {//method to check player score regarding game over screen

  if (p.started ) {
    if (p.health <=0) {
      PlayerDead+=1;
      p.started= false;
    }
  }//end if started
}//end PlayerScoreCheck

