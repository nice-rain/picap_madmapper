import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress madMapper;
int value = 0;

int numElectrodes  = 12;
int[] status, lastStatus;
String[] mediasList = new String [numElectrodes];

//Import our particle system
ParticleSystem ps;
Collider col;
ArrayList<Collider> colliders = new ArrayList<Collider>();


//Function to generate and store all colliders in an array
void generateColliders(int numRows, int numColumns)
{
  for (int i = 0; i < numRows + 1; i++)
  {
     for (int c = 0; c < numColumns + 1; c++)
    {
      Collider newCol = new Collider(c*100+200, i*100+200);
      colliders.add(newCol);
    }
  }
}

void updateArrayOSC(int[] array, Object[] data) {
  if (array == null || data == null) {
    return;
  }

  for (int i = 0; i < min(array.length, data.length); i++) {
    array[i] = (int)data[i];
  }
}

//Position of th eline
float yPos = 0.0;

void setup() {
  // setup OSC receiver on port 3000
  oscP5 = new OscP5(this, 1400);
  madMapper = new NetAddress("127.0.0.1", 8010);
  
  status            = new int[numElectrodes];
  lastStatus        = new int[numElectrodes];
  
  mediasList[0] = "bubble_animation.mp4";
  mediasList[1] = "square_animation.mp4";

  size(1280, 800);
  frameRate(60);

  //collider spawn
  col = new Collider(width/2 - 25, 140, 25);

  //Particle system spawn
  ps = new ParticleSystem(new PVector(width/2, 50));

  //Generate all colliders
  generateColliders(5, 11);
}

void draw() {  // draw() loops forever, until stopped
  yPos = yPos - 1.0;
  if (yPos < 0) {
    yPos = height;
  }
  line(0, yPos, width, yPos);

  //Draw our particle system
  background(0);

   //set gravite
  PVector gravity = new PVector(0,0.1);

  ps.addParticle();

  ps.applyForce(gravity);

  //ps.applyCollision(col);
  
  ps.run();
  //col.display();

  for (Collider c: colliders){
    ps.applyCollision(c);
    c.display();
  }
}

void oscEvent(OscMessage oscMessage) {
    if (oscMessage.checkAddrPattern("/touch")) {
      updateArrayOSC(status, oscMessage.arguments());
    }
    
    for (int i = 0; i < numElectrodes; i++) {
      if (lastStatus[i] == 0 && status[i] == 1) {
        // touched
        println("Electrode " + i + " was touched");
        lastStatus[i] = 1;
        sendMMMessage(true, i);
      } 
      else if(lastStatus[i] == 1 && status[i] == 0) {
        // released
        println("Electrode " + i + " was released");
        lastStatus[i] = 0;
        sendMMMessage(false, i);
      }
    }
}

void sendMMMessage(boolean begin, int electrode) {
  OscMessage msg = new OscMessage("/medias/" + mediasList[electrode] + "/begin");
  msg.add(begin);
  
  // send it to MadMapper
  oscP5.send(msg, madMapper);
}
