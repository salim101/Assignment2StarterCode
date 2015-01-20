/*
    DIT OOP Assignment 2 Starter Code
 =================================
 
 Loads player properties from an xml file
 See: https://github.com/skooter500/DT228-OOP 
 */

ArrayList<GameObject> allobjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[526];
float game_speed = 1.1f, slowdown = 1.0f;

PImage imgStart;
PFont font1, font2;
int Cent_X, Cent_Y;


String game_state = "first_screen";
float max_speed = 20, min_speed = 5;

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



  allobjects.add(new Background(-height, width, height*2, "road.jpg"));

  for (int i = 0; i < 4; i++) {
    allobjects.add(new Car("Bad_Car" + (i+1) + ".png"));
  }




  setUpPlayerControllers();
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



  if (game_state == "playing")
  {

    println(allobjects.size());

    for (int i = 0; i < allobjects.size (); i++) {


      // It's a player
      if (allobjects.get(i) instanceof Player) {
        Player p = (Player) allobjects.get(i);
        inBounds(p);
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
      } // Player.

      // It's the background
      if (allobjects.get(i) instanceof Background) {
        allobjects.get(i).speed = game_speed;
      } // Background.

      // It's a car
      if (allobjects.get(i) instanceof Car) {
        respawnCars(allobjects.get(i));
      } // Car.
      
      if(allobjects.get(i).alive == false){
        allobjects.remove(allobjects.get(i));
      }
      allobjects.get(i).update();
      allobjects.get(i).display();
    } // End for loop.




    /*
    for (GameObject eachobject : allobjects)
     {
     
     // It's a player
     if (eachobject instanceof Player) {
     Player p = (Player) eachobject;
     inBounds(p);
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
     } // Player.
     
     // It's the background
     if (eachobject instanceof Background) {
     eachobject.speed = game_speed;
     } // Background.
     
     // It's a car
     if (eachobject instanceof Car) {
     respawnCars(eachobject);
     } // Car.
     
     eachobject.update();
     eachobject.display();
     }
     */
  } // End playing.
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
    p.pos.y = 540;
    allobjects.add(p);
    x += gap;
  }
}







void inBounds(GameObject player)
{
  if (player.pos.x > ((width/4)*3) -player.w)
  {
    player.pos.x = ((width/4)*3) -player.w;
  } else if (player.pos.x < width/4)
  {
    player.pos.x = width/4;
  }

  if (player.pos.y < 240)
  {
    player.pos.y = 240;
  } else if (player.pos.y > 540)
  {
    player.pos.y = 540;
  }
}




void respawnCars(GameObject car) {
  if (car.pos.y > height) {
    car.alive = false;
    int rnd = (int) random(1, 5);
    allobjects.add(new Car("Bad_Car" + rnd + ".png"));
    
  }
}

