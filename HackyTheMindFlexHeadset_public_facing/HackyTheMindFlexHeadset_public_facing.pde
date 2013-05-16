/****************

 This code was written for Cosm, but works just fine with Xively!
 
 I combined the bones of the Mindflex Brain Grapher 
 (https://github.com/kitschpatrol/Processing-Brain-Grapher) 
 with the Cosm Processing "Simple Put" example 
 (https://github.com/jmsaavedra/Cosm-Processing-Library).  
 
 Make an account at Xively.com, get an API KEY and a FEED ID, run the sketch and watch the magic. No need to create the channels on Xively,
 the sketch will create them automatically :-D.
 
 This is a first commit and needs to be cleaned.
 
 Also, as soon as an error posts, you'll need to start the sketch again.
 
 It's buggy, but fun for real.
 
 ****************/
import processing.serial.*;
import controlP5.*;
import cosm.*;

DataOut feed;

String apiKey = "API KEY HERE";
String feedId = "FEED ID HERE";

Serial serial;
int lf = 10;	// ASCII linefeed

int count=0;//count incoming packets
String fileName="think_1";

String[] incomingValues;

int packetCount = 0;
int globalMax;
String scaleMode;

String[] data;
void setup() {

  feed = new DataOut(this, apiKey, feedId);  //intantiate feed
  feed.setVerbose(false);  //optional debug info

  smooth();
  //font = new ControlFont(createFont("DIN-MediumAlternate", 12), 12);
  // Create each channel
  serial = new Serial(this, Serial.list()[0], 9600);	
  serial.bufferUntil(10);

//  fontA = loadFont("Ziggurat-HTF-Black-32.vlw");
  // Set the font and its size (in units of pixels)
  //     textFont(fontA, 32);
  //sendRandomVal();
  sendBrainData();
}

void draw() {

  //awesome stuff goes here
}

void sendBrainData() {

  for (int i=0;i<1000000;i++) {  
    delay(1000000000);
    i+=1;
  }
  for (int j=0;j<100;j++) {
    data = loadStrings("data.txt");
    if (data[0]!="0" && data[0]!="ERROR: Packet too long") {
      feed.setStream(0, data[0]);
      //delay(1000000000);

      feed.setStream(1, data[1]);
      //delay(1000000000);
      feed.setStream(2, data[2]);
      //delay(1000000000);
      feed.setStream(3, data[3]);
      delay(1000000000);
      feed.setStream(4, data[4]);
      //delay(1000000000);
      feed.setStream(5, data[5]);
      delay(1000000000);
      feed.setStream(6, data[6]);
      //delay(1000000000);
      feed.setStream(7, data[7]);
      delay(1000000000);
      feed.setStream(8, data[8]);
      //delay(1000000000);
      feed.setStream(9, data[9]);
      delay(1000000000);
      feed.setStream(10, data[10]);
      //delay(1000000000);
      j+=1;
    }

    for (int i=0;i<20;i++) {  
      delay(1000000000);
      i+=1;
    }
  }
}

void sendRandomVal() {
  float randomVal = random(1023); //create a random value
  feed.setStream(0, randomVal); //send request (datastream id, new value)
  println(randomVal); //look at number printed, then check your feed on cosm!
}

void keyPressed() {
  sendRandomVal();
}


void serialEvent(Serial p) {
  incomingValues = split(p.readString(), ',');

  println(incomingValues);
  count+=1;

  saveStrings(dataPath("data.txt"), incomingValues);
  // Add the data to the logs
  if (incomingValues.length > 1) {
    packetCount++;

    // Wait till the third packet or so to start recording to avoid initialization garbage.
    if (packetCount > 3) {
      for (int i = 0; i < incomingValues.length; i++) {
        int newValue = Integer.parseInt(incomingValues[i].trim());

        // Zero the EEG power values if we don't have a signal.
        // Can be useful to leave them in for development.
        if ((Integer.parseInt(incomingValues[0]) == 200) && (i > 2)) newValue = 0;
      }
    }
  }
}
// Extend core's Map function to the Long datatype.
long mapLong(long x, long in_min, long in_max, long out_min, long out_max) { 
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

long constrainLong(long value, long min_value, long max_value) {
  if (value > max_value) return max_value;
  if (value < min_value) return min_value;
  return value;
}

