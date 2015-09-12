import java.util.PriorityQueue;


public class FancyClass implements Comparable<FancyClass> {

  // Required when implementing Comparable
  public int compareTo(FancyClass other) {
    return this.somenumber.compareTo(other.somenumber);
  }

  // This must be an Integer and not an int primitive
  // or compareTo will throw an exception.
  Integer somenumber;
  String name;

  FancyClass(String _name) {
    name = _name;
  }

  // Custom print value for the class
  public String toString() {
    return name + ": " + somenumber;
  }
}



FancyClass fc1, fc2, fc3, fc4;
PriorityQueue<FancyClass> pq;

void setup() {
  fc1 = new FancyClass("fc1");
  fc2 = new FancyClass("fc2");
  fc3 = new FancyClass("fc3");
  fc4 = new FancyClass("fc4");

  fc1.somenumber = 12;
  fc2.somenumber = -1;
  fc3.somenumber = 7;
  fc4.somenumber = 99;

  // Here we do not need to implement a comparator because FancyClass implements Comparable
  // and the compareTo method, which is the "natural ordering" for the FancyClass class.
  // The 5 is simply the capacity of the priority queue.
  pq = new PriorityQueue<FancyClass>(5);

  // offer() and add() are the same for PriorityQueue
  pq.offer(fc1);
  pq.offer(fc2);
  pq.offer(fc3);
  pq.offer(fc4);
}

void draw() {
  // Note, this will NOT print them in order!!
  println(pq);
  
  // You can only get them in order by polling the queue.
  while (!pq.isEmpty ()) {
    println("Item: " + pq.poll());
  }
  
  noLoop();
}

