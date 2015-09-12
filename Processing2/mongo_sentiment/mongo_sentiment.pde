import peasy.*;

PeasyCam cam;

import com.mongodb.selector.*;
import com.mongodb.bulk.*;
import com.mongodb.*;
import com.mongodb.gridfs.*;
import com.mongodb.client.*;
import com.mongodb.internal.management.jmx.*;
import com.mongodb.annotations.*;
import com.mongodb.internal.async.*;
import com.mongodb.client.model.*;
import com.mongodb.connection.netty.*;
import com.mongodb.internal.validator.*;
import com.mongodb.event.*;
import com.mongodb.util.*;
import org.bson.*;
import com.mongodb.operation.*;
import com.mongodb.assertions.*;
import com.mongodb.binding.*;
import org.bson.assertions.*;
import org.bson.json.*;
import org.bson.codecs.*;
import org.bson.util.*;
import com.mongodb.client.result.*;
import com.mongodb.async.*;
import com.mongodb.internal.authentication.*;
import org.bson.conversions.*;
import com.mongodb.management.*;
import com.mongodb.internal.connection.*;
import com.mongodb.connection.*;
import org.bson.diagnostics.*;
import com.mongodb.diagnostics.logging.*;
import org.bson.types.*;
import org.bson.io.*;
import org.bson.codecs.configuration.*;

int size = 1000;

MongoClientURI connectionString;
MongoClient    mongoClient;
MongoDatabase  database;
MongoCollection<Document> collection;

ArrayList<PVector> points;

Block<Document> plotBlock = new Block<Document>() {
  @Override
    public void apply(final Document document) {
    // println(document.getDouble("anew_dm"));
    try {
      double a = document.getDouble("anew_am");
      double v = document.getDouble("anew_vm");
      double d = document.getDouble("anew_dm");

      float fa, fv, fd;

      fa = map((float)a, 0, 10, 0, size);
      fv = map((float)v, 0, 10, 0, size);
      fd = map((float)d, 0, 10, 0, size);

      fill(map(fa, 0, size, 0, 255), map(fv, 0, size, 0, 255), map(fd, 0, size, 0, 255));

      // ellipse(fa,fv, 2, 2);
      pushMatrix();
      translate(fa, fv, fd);
      sphere(2);
      popMatrix();
    } 
    catch (Exception e) {
      //println("error");
    } 
    finally {
    }
  }
};

Block<Document> savePoint = new Block<Document>() {
  @Override
    public void apply(final Document document) {
    // println(document.getDouble("anew_dm"));
    try {
      double a = document.getDouble("anew_am");
      double v = document.getDouble("anew_vm");
      double d = document.getDouble("anew_dm");

      float fa, fv, fd;

      fa = map((float)a, 0, 10, 0, size);
      fv = map((float)v, 0, 10, 0, size);
      fd = map((float)d, 0, 10, 0, size);
      points.add(new PVector(fa, fv, fd));
    } 
    catch (Exception e) {
    } 
    finally {
    }
  }
};

void setup() {
  size(size, size, P3D);
  background(0);

  connectionString = new MongoClientURI("mongodb://localhost:27017");
  mongoClient      = new MongoClient(connectionString);
  database         = mongoClient.getDatabase("aggregation_2015_04_17__12_43_06");
  collection       = database.getCollection("reference");

  points = new ArrayList<PVector>();
  cam    = new PeasyCam(this,size/2,size/2,size/2,size/2);

  noStroke();
  directionalLight(255,255,255,-1,0,0);
  collection.find().forEach(savePoint);
  perspective();
}

void draw() {
  background(0);
  lights();
  
  for (PVector point : points) {
    pushMatrix();
    translate(point.x, point.y, point.z);
    fill(map(point.x, 0, size, 0, 255), map(point.y, 0, size, 0, 255), map(point.z, 0, size, 0, 255));
    sphere(1);
    popMatrix();
  }
  // noLoop();
}

void stop() {
  println("exiting");
  mongoClient.close();
}

