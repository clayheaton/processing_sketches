PFont f;

size(600, 600);
background(255);

// Create a font
f = createFont("Miriam", 24);

// Load a pre-created bitmap font
// f = loadFont("Miriam-24.vlw");

// Sets the font that the text() function will use
textFont(f);

fill(0);
textAlign(RIGHT);
text("How are you doing?", width * 0.5, height * 0.25);

fill(#ff0000);
textAlign(CENTER);
text("I'm just great, thanks!", width * 0.5, height * 0.5);

fill(#0000ff);
textAlign(LEFT);
text("OK! See you later!", width * 0.5, height * 0.75);

