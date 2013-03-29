color dest_color = color(243, 255, 0);
color start_color = color(0, 110, 0);
int glow_period_in_seconds = 3;
int target_frameRate = 60;

void setup() {
size(640, 360);
background(0);
noStroke();
frameRate(target_frameRate);
}

void draw() {
  
background(alternateColors(start_color, dest_color, glow_period_in_seconds, 
           target_frameRate));
}
//*********************THIS LINE IS 80 CHARACTERS LONG**************************
color alternateColors(color _start_color, color _dest_color, 
                      int _period_in_seconds,
                      int _target_frameRate) {
  color start_color = _start_color;
  color dest_color = _dest_color;
  
  //calculate how many frames a complete cycle of glowing will take, going
  //all the way from the start_color to the dest_color and then back.
  //I can't use the system variable frameRate because it may change if the comp
  //can't calculate fast enough to hit the target framerate.
  float glow_period_in_frames = int(_target_frameRate * _period_in_seconds);
  float current_position_in_the_period = frameCount % glow_period_in_frames;

  //calculate the total distance we need to travel from one color to the other
  int total_red_change = int(red(dest_color)) - int(red(start_color));
  int total_green_change = int(green(dest_color)) - int(green(start_color));
  int total_blue_change = int(blue(dest_color)) - int(blue(start_color));
  
  //calculate how much each color channel needs to be adjusted from the
  //starting color.
  float red_adjustment;
  float green_adjustment;
  float blue_adjustment;
  if (current_position_in_the_period < (glow_period_in_frames / 2)) {
    red_adjustment = total_red_change * (current_position_in_the_period /
                        glow_period_in_frames) * 2;
    green_adjustment = total_green_change * (current_position_in_the_period /
                        glow_period_in_frames) * 2;
    blue_adjustment = total_blue_change * (current_position_in_the_period /
                        glow_period_in_frames) * 2;
  } else {
    red_adjustment = total_red_change * ((-2 * (current_position_in_the_period /
                        glow_period_in_frames)) + 2);
    green_adjustment = total_green_change * ((-2 * (current_position_in_the_period /
                        glow_period_in_frames)) + 2);
    blue_adjustment = total_blue_change * ((-2 * (current_position_in_the_period /
                        glow_period_in_frames)) + 2);
  }
  
  //to make sure I make the right decision about adding or subracting the nec.
  //change in value, I need to check whether I am [currently moving from the
  //starting color to the destination color] or if it's vice versa.
  float new_red = red(start_color) + (red_adjustment);
  float new_green = green(start_color) + (green_adjustment);
  float new_blue = blue(start_color) + (blue_adjustment);

  return color(new_red, new_green, new_blue);
}
