/**
 * oscP5plug by andreas schlegel
 * example shows how to use the plug service with oscP5.
 * the concept of the plug service is, that you can
 * register methods in your sketch to which incoming 
 * osc messages will be forwareded automatically without 
 * having to parse them in the oscEvent method.
 * that a look at the example below to get an understanding
 * of how plug works.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);
  frameRate(25);
  oscP5 = new OscP5(this,7777);
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 7777);
}

void draw() {
  background(0);
  fill(255);
  text("SENDER", width/2, height/2);
}


void mousePressed() {

  if (mouseX > width/2) {
    OscMessage myMessage;
    myMessage = new OscMessage("/test");
    myMessage.add(123); /* add an int to the osc message */
    myMessage.add(456); /* add a second int to the osc message */
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
    println(myMessage);
  } else {
    OscMessage myMessage;
    myMessage = new OscMessage("/a");
    myMessage.add(789); /* add an int to the osc message */
    myMessage.add(012); /* add a second int to the osc message */
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
    println(myMessage);
  }
}
