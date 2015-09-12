import java.util.PriorityQueue;
import java.util.Comparator;

public class FancyClass {

  // This doesn't need to be an Integer in this case
  int somenumber;
  int someothernumber;
  String name;

  FancyClass(String _name) {
    name = _name;
  }

  // Custom print value for the class
  public String toString() {
    return name + ", somenumber:" + somenumber + ", someothernumber: " + someothernumber;
  }
}

// The Comparators that look at different numbers in FancyClass
static class FancySortOne implements Comparator<FancyClass> {
  public int compare(FancyClass one, FancyClass two) {
    return one.somenumber - two.somenumber;
  }
}

static class FancySortTwo implements Comparator<FancyClass> {
  public int compare(FancyClass one, FancyClass two) {
    // Note the difference
    return one.someothernumber - two.someothernumber;
  }
}

FancyClass fc1, fc2, fc3, fc4;
PriorityQueue<FancyClass> pq, pq2;

void setup() {
  fc1 = new FancyClass("fc1");
  fc2 = new FancyClass("fc2");
  fc3 = new FancyClass("fc3");
  fc4 = new FancyClass("fc4");

  fc1.somenumber = 12;
  fc2.somenumber = -1;
  fc3.somenumber = 7;
  fc4.somenumber = 99;

  fc1.someothernumber = 2;
  fc2.someothernumber = 17;
  fc3.someothernumber = 79;
  fc4.someothernumber = 4;

  FancySortOne fs1 = new FancySortOne();
  FancySortTwo fs2 = new FancySortTwo();

  // Provide the Comparator as a parameter
  pq  = new PriorityQueue<FancyClass>(5, fs1);
  pq2 = new PriorityQueue<FancyClass>(5, fs2);

  // offer() and add() are the same for PriorityQueue
  pq.offer(fc1);
  pq.offer(fc2);
  pq.offer(fc3);
  pq.offer(fc4);

  pq2.offer(fc1);
  pq2.offer(fc2);
  pq2.offer(fc3);
  pq2.offer(fc4);
}

void draw() {
  // Note, this will NOT print them in order!!
  println(pq);

  // You can only get them in order by polling the queue.
  while (!pq.isEmpty ()) {
    println("Item: " + pq.poll());
  }

  // Now look at the other comparator
  println("\n------------------------------------------\n");

  // Note, this will NOT print them in order!!
  println(pq2);

  // You can only get them in order by polling the queue.
  while (!pq2.isEmpty ()) {
    println("Item: " + pq2.poll());
  }

  noLoop();
}

