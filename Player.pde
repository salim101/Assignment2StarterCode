class Player extends GameObject
{
  //set the audio player
  AudioPlayer Coin_Sound;
  AudioPlayer Player_Start_Sound;
  AudioPlayer Accelerator_Sound;
  AudioPlayer Player_left_right_Sound;
  AudioPlayer bullet_Sound;
  AudioPlayer bomb_Sound;

  //declare variables 
  //PVector pos;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  char insertcoin;
  int index;
  //color colour;
  PImage player_img;
  int coin = 0;
  boolean started;
  int score;
  int health;


  ArrayList<GameObject> bullets = new ArrayList<GameObject>(); // create the arraylist of player bullets
  ArrayList<GameObject> bombs = new ArrayList<GameObject>(); // create the arraylist of player bombs


  Player()
  {
    // alive=false;
    pos = new PVector(width / 2, height / 2);
    score = 0;
    health=50;
    
    //load the audio sound
    Coin_Sound= minim.loadFile("Coin_Insertion.wav");
    Player_Start_Sound= minim.loadFile("car_start.wav");
    Accelerator_Sound= minim.loadFile("car_accelerating.wav");
    Player_left_right_Sound= minim.loadFile("car_left_right.wav");
    bullet_Sound= minim.loadFile("bullet.wav");
    bomb_Sound= minim.loadFile("bomb.wav");
  }//end Player

  Player(int index, String imgPath, char up, char down, char left, char right, char start, char button1, char button2, char insertcoin)
  {
    this();
    this.index = index;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    this.insertcoin= insertcoin;
    player_img = loadImage(imgPath);
  }//end PLayer

  Player(int index, String imgPath, XML xml)
  {
    this(index
      , imgPath
      , buttonNameToKey(xml, "up")
      , buttonNameToKey(xml, "down")
      , buttonNameToKey(xml, "left")
      , buttonNameToKey(xml, "right")
      , buttonNameToKey(xml, "start")
      , buttonNameToKey(xml, "button1")
      , buttonNameToKey(xml, "button2")
      , buttonNameToKey(xml, "insertcoin")
      );
  }//end Player

  void update()
  {
    if (checkKey(insertcoin))
    {
      Coin_Sound.play(); 
      Coin_Sound.rewind();
      coin =1;
    }

    if (started) {
      if (checkKey(up))
      {
        //Accelerator_Sound.rewind();
        //Accelerator_Sound.play();
        pos.y -= speed;
      }
      if (checkKey(down))
      {
        pos.y += speed;
      }
      if (checkKey(left))
      {
        //if (frameCount % 15 == 0) {
        // Player_left_right_Sound.rewind();
        // Player_left_right_Sound.play();
        // }
        pos.x -= speed;
      }    
      if (checkKey(right))
      {
        // Player_left_right_Sound.rewind();
        // Player_left_right_Sound.play();
        pos.x += speed;
      }
    }

    if (checkKey(start) && coin > 0)
    {
      Player_Start_Sound.rewind();
      Player_Start_Sound.play(); 
      coin = 0;
      PlayerPlaying+=1;
      started = true;
    }

    if (checkKey(button1))
    {

      if (frameCount % 10 == 0) {
        bullet_Sound.rewind();
        bullet_Sound.play();
        bullets.add(new Bullet(pos.x + 6, pos.y, "bullet.png", 8.0));//add the bullet to the arraylist
        bullets.add(new Bullet(pos.x + 30, pos.y, "bullet.png", 8.0));//add the bullet to the arraylist
      }
    }
    if (checkKey(button2))
    {

      if (frameCount % 10 == 0) {
        bomb_Sound.rewind();
        bomb_Sound.play();
        bombs.add(new Bomb(pos.x + 15, pos.y, "bomb.png", 8.0));//add the bomb to the arraylist
      }
    }
  }//end update

  void display()
  {
    if (started) {
      for (int i = 0; i < bullets.size (); i++) {

        bullets.get(i).update();//update the bullets
        bullets.get(i).display();//display the bullets

        if (bullets.get(i).pos.y + bullets.get(i).h < 0) {
          bullets.get(i).alive = false; //make the bullet false when it gets over the screen
        }

        if (bullets.get(i).alive == false) {
          bullets.remove( bullets.get(i) );//remove the bullets when its false
        }
      }

      for (int i = 0; i < bombs.size (); i++) {

        bombs.get(i).update(); //update the bombs
        bombs.get(i).display(); //display the bombs

        if (bombs.get(i).pos.y + bombs.get(i).h < 0) {
          bombs.get(i).alive = false; //make the bomb false when it gets over the screen
        }

        if (bombs.get(i).alive == false) {
          bombs.remove( bombs.get(i) );//remove the bombs when its false
        }
      }
      image(player_img, pos.x, pos.y, w, h);
    }
  } // End display
}

