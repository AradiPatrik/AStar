public enum Color{
  
  BLACK(0,0,0),
  WHITE(255,255,255),
  RED(255,0,0),
  GREEN(0,255,0),
  BLUE(0,0,255);
  
  private final int red;
  private final int green;
  private final int blue;
  
  private Color(int red, int green, int blue){
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
  
  PVector toVector(){ return new PVector(red, green, blue); }
}