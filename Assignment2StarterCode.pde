/*
    DIT OOP Assignment 2 Starter Code
 =================================
 
 Loads player properties from an xml file
 See: https://github.com/skooter500/DT228-OOP 
 */

ArrayList<GameObject> allobjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[526];
float game_speed = 1.1f, slowdown = 1.0f;

PImage imgStart, imgOver;
PFont font1, font2;
int Cent_X, Cent_Y;
int score =0;

String game_state = "first_screen";
float max_speed = 20, min_speed = 5;
int counter = 10;

/*
boolean sketchFullScreen()
 {
 return true;
 }
 */

void setup()
{
  size(700, 700);
  Cent_X = width / 2; 
  Cent_Y = height / 2;

  imgStart = loadImage("SpyHunter.jpg");
  font1=createFont("Britannic Bold", 25);
  imgOver= loadImage("GameOver.jpg");


  allobjects.add(new Background(-height, width, height*2, "road.jpg"));

  setUpPlayerControllers();


  for (int i = 0; i < 6; i++) {
    allobjects.add(new Car("Bad_Car" + (i+1) + ".png"));
  }

  allobjects.add(new Extra_Health("extralive.png"));

  allobjects.add(new Horse("horse.png"));
}







void draw()
{


  if (game_state == "first_screen")
  {
    image(imgStart, 0, 0, width, height);

    textFont(font1);
    fill(255, 0, 0);
    text("Insert Coin to Play the Game", Cent_X-140, Cent_Y+200);

    for (GameObject eachobject : allobjects)
    {

      if (eachobject instanceof Player) {
        eachobject.update();
        if (eachobject instanceof Player) {
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
            game_state = "playing";
          }
        }
      }
    }
  } // End first screen.



  else if (game_state == "playing")
  {


    for (int i = 0; i < allobjects.size (); i++) {


      // It's the background
      if (allobjects.get(i) instanceof Background) {
        allobjects.get(i).speed = game_speed;
      } // Background.




      // It's a car
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
      } // Car.



      // It's a horse
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
      } // horse.



      // It's a extra health
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
      }//end extra health




      // It's a player
      if (allobjects.get(i) instanceof Player) {
        Player p = (Player) allobjects.get(i);
        PlayersInfo(p);
        inBounds(p);
        PlayerScore(p);
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
            PlayerCrashesIntoPlayer(p, p2);
          }

          if ( allobjects.get(j) instanceof Car) {
            Car c = (Car) allobjects.get(j);
            PlayerShootCar(p, c);
          }
          
          if ( allobjects.get(j) instanceof Horse) {
            Horse h = (Horse) allobjects.get(j);
            PlayerShootHorse(p, h);
          }
        }
      } // Player.




      allobjects.get(i).update();
      allobjects.get(i).display();

      if (allobjects.get(i).alive == false) {
        allobjects.remove(allobjects.get(i));
      }
    } // End for loop.
  } // End playing.

  else if (game_state == "GameOver") {
    // background(0);
    //textFont(font1);
    //fill(255, 0, 0);
    //text("Game Over", Cent_X-50, Cent_Y-300);
    image(imgOver, 0, 0, width, height);
    ////////////////////////////////////////////////////////////////////////
    for (GameObject eachobject : allobjects)
    {
      if (eachobject instanceof Player) {
        Player p = (Player) eachobject;

        if (p.index == 1 && p.started) {
          textFont(font1);
          fill(255, 128, 0);
          text("Player 1: ", Cent_X-330, Cent_Y-180);
          text("Score: " + p.score, Cent_X-330, Cent_Y-140);
          p.alive=false;
          //p.started=false;
          
        }
        if (p.index == 2 && p.started) {
          textFont(font1);
          fill(0, 255, 0);
          text("Player 2: ", Cent_X+200, Cent_Y-180);
          text("Score: " + p.score, Cent_X+200, Cent_Y-140);
          p.alive=false;
          //p.started=false;
        }
      }
    }
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
  int gap =325;
  int x = 155;
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







void inBounds(GameObject player)
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




void respawnCars(GameObject car) {
  if (car.pos.y > height) {
    car.alive = false;
    int rnd = (int) random(1, 5);
    allobjects.add(new Car("Bad_Car" + rnd + ".png"));
  }
}//end respawnCars

void respawnExtraHealth(GameObject eh) {
  if (eh.pos.y > height) {
    eh.alive = false;
    allobjects.add(new Extra_Health("extralive.png"));
  }
}//end respawnExtraHealth

void respawnHorse(GameObject horse) {
  if (horse.pos.y > height) {
    horse.alive = false;
    allobjects.add(new Horse("horse.png"));
  }
}//end respawnExtraHealth



void carCrashesIntoPlayer(Car c, Player p) {
  if (p.started) {
    if (c.pos.y + c.h > p.pos.y && c.pos.y < p.pos.y + p.h && c.pos.x + c.w > p.pos.x && c.pos.x < p.pos.x+p.w) {
      c.alive = false;
      int rnd = (int) random(1, 6);
      allobjects.add(new Car("Bad_Car" + rnd + ".png"));
      p.health-=10;
    }
  }
}//end carCrashesIntoPlayer


void PlayerShootCar(Player p, Car c) {
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

void PlayerShootHorse(Player p, Horse h) {
  if (p.started) {
    for (int i =0; i < p.bullets.size (); i++) {
      if (p.bullets.get(i).pos.y < h.pos.y + h.h &&
        p.bullets.get(i).pos.y + p.bullets.get(i).h > h.pos.y &&
        p.bullets.get(i).pos.x + p.bullets.get(i).w > h.pos.x &&
        p.bullets.get(i).pos.x < h.pos.x + h.w) {
        p.bullets.get(i).alive = false;
        p.score +=10;
        h.alive = false;
        allobjects.add(new Horse("horse.png"));
      }
    }
  }
}//end PlayerShootHorse


void HorseCrashesIntoPlayer(Horse h, Player p) {
  if (p.started) {
    if (h.pos.y + h.h > p.pos.y && h.pos.y < p.pos.y + p.h && h.pos.x + h.w > p.pos.x && h.pos.x < p.pos.x+p.w) {
      h.alive = false;

      allobjects.add(new Horse("horse.png"));
      p.health-=20;
    }
  }
}//HorseCrashesIntoPlayer

void PlayerCrashesIntoPlayer(Player p1, Player p2) {
  if (p1.started && p2.started) {
    if (p1.pos.y < p2.pos.y + p2.h &&
      p1.pos.y + p1.h > p2.pos.y &&
      p1.pos.x + p1.w > p2.pos.x &&
      p1.pos.x < p2.pos.x + p2.w) {

      //p1.alive = false;
      //p2.alive = false;
      p1.speed = -p1.speed;
      p2.speed = -p2.speed;
      println("player crashed");
    }
  }
}//end PlayerCrashesIntoPlayer


void PlayersInfo(Player p) {

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
}

void PLayerGetsExtraHealth(Extra_Health eh, Player p ) {
  if (p.started) {
    if (eh.pos.y + eh.h > p.pos.y && eh.pos.y < p.pos.y + p.h && eh.pos.x + eh.w > p.pos.x && eh.pos.x < p.pos.x+p.w) {
      eh.alive = false;
      //int rnd = (int) random(1, 6);
      allobjects.add(new Extra_Health("extralive.png"));

      if (p.health < 50) {
        p.health +=10;
      }
    }
  }
}

void PlayerScore(Player p) {
  if (p.started) {
    if (p.index == 1 && p.health ==0) {
      textFont(font1);
      fill(255, 0, 0);
      text("PLayer 1 gone", Cent_X-330, Cent_Y-100);
      game_state = "GameOver";
      //p.alive=false;
    } else if (p.index == 2 && p.health ==0) {
      
      textFont(font1);
      fill(255, 0, 0);
      text("PLayer 2 gone", Cent_X+200, Cent_Y-100);
      game_state = "GameOver";
     // p.alive=false;
    }
    /*
       else if(p.index == 1 && p.health ==0  && p.alive==false ) {
     //p.alive=false;
     textFont(font1);
     fill(255, 0, 0);
     text("Game Over", Cent_X, Cent_Y);
     }
     */
  }
}

