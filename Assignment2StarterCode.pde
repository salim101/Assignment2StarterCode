/*
    DIT OOP Assignment 2 Starter Code
 =================================
 
 Loads player properties from an xml file
 See: https://github.com/skooter500/DT228-OOP 
 */

ArrayList<GameObject> allobjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[526];
float gameSpeed = 0.1f, slowdown = 1.0f;





void setup()
{
  size(500, 500);

  allobjects.add(new Background(-500, 500, 1000, "road.jpg"));
  setUpPlayerControllers();
}







void draw()
{
  for (GameObject eachobject : allobjects)
  {
    eachobject.update();
    eachobject.display();

    if (eachobject instanceof Player) {
      
      eachobject.pos.y += slowdown;
      
      if (eachobject.pos.y < 250) {
        if (gameSpeed < 10.0f) {
          gameSpeed += 0.1f;
        }
      } else if (eachobject.pos.y > 400) {
        if (gameSpeed > 2.0f) {
          gameSpeed -= 0.1f;
        }
      }
      
      inBounds(eachobject);
    }



    if (eachobject instanceof Background) {
      eachobject.speed = gameSpeed;
    }
  }
}

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
  int gap =230;
  int x = 115;
  for (int i = 0; i < children.length; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(
    i
      , "Car_1.png"
      , playerXML);
    p.pos.x = x;
    p.pos.y = 420;
    allobjects.add(p);
    x += gap;
  }
}






void inBounds(GameObject player)
{
  if (player.pos.x > width - player.w)
  {
    player.pos.x = width - player.w;
  }else if (player.pos.x < 0)
  {
    player.pos.x = 0;
  }
  
  
  
  
  if (player.pos.y > 420)
  {
    player.pos.y = 420;
  }
}

