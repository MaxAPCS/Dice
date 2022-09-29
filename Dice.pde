import java.awt.Point;
import java.util.List;

List<Die> dice = new ArrayList<Die>();
void setup() {
  size(360, 360);
	noLoop();
  noStroke();
  textSize(24);
  textAlign(TOP, RIGHT);
  for (int x = Die.size/2; x <= 360 - Die.size/2; x += Die.size+12)
    for (int y = Die.size/2; y <= 360 - Die.size/2; y += Die.size+12)
      dice.add(new Die(new Point(x,y)));
}

void draw() {
  background(0x999999);
  int sum = 0;
  for (Die die : dice) {
    die.draw();
    sum += die.getValue();
  }
  fill(0xbb222222);
  text("Total: "+sum, 0, 360);
}

void mousePressed() {
  for (Die die : dice)
    die.roll();
	redraw();
}

class Die { // this should be a record
  public static final int size = 48;
  private static final int spacing = 7;
  public Point coords;
  public int sides;
  public int value;
  
  public Die(Point coords) {
    this.coords = coords;
    this.sides = 6;
    this.roll();
  }
  
  public int getValue() {return this.value;}
  
	public void roll() {
		this.value = (int)(Math.random()*sides)+1;
	}

	public void draw() {
    switch (sides) {
      case 6:
        fill(0xFFFFFFFF);
        rect(this.coords.x-size/2, this.coords.y-size/2, size, size);
        fill(0);
        if (this.value % 2 == 1) ellipse(this.coords.x, this.coords.y, 10, 10);
        if (this.value >= 2) {
          ellipse(this.coords.x-size/2+spacing, this.coords.y-size/2+spacing, 10, 10);
          ellipse(this.coords.x+size/2-spacing, this.coords.y+size/2-spacing, 10, 10);
        }
        if (this.value >= 4) {
          ellipse(this.coords.x+size/2-spacing, this.coords.y-size/2+spacing, 10, 10);
          ellipse(this.coords.x-size/2+spacing, this.coords.y+size/2-spacing, 10, 10);
        }
        if (this.value == 6) {
          ellipse(this.coords.x+size/2-spacing, this.coords.y, 10, 10);
          ellipse(this.coords.x-size/2+spacing, this.coords.y, 10, 10);
        }
      break;
      default:
        // nah
      break;
    }
	}
}
