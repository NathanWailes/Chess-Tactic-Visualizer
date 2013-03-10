color dest_color = color(243, 255, 0);
color start_color = color(0, 110, 0);
float glow_period_in_seconds = 3;
int frame_counter = 1;

void setup() {
size(640, 360);
background(0);
noStroke();
frameRate(60);

}

void draw() {
  
background(colorSwitcher(start_color, dest_color));
}
//*********************THIS LINE IS 80 CHARACTERS LONG**************************
color colorSwitcher(color _start_color, color _dest_color) {
  color start_color = _start_color;
  color dest_color = _dest_color;
  
  float red_delta = red(dest_color) - red(start_color);
  float green_delta = green(dest_color) - green(start_color);
  float blue_delta = blue(dest_color) - blue(start_color);
  
  //calculate how many frames a complete cycle of glowing will take, going
  //all the way from the start_color to the dest_color and then back.
  float glow_frame_period = frameRate * glow_period_in_seconds;
  
  //calculate how much each color channel needs to change THIS frame.  This
  //doesn't figure out if we need to add or subtract this amount from the
  //current color; I leave that 'til later.
  float red_change = red_delta / glow_frame_period;
  float green_change = green_delta / glow_frame_period;
  float blue_change = blue_delta / glow_frame_period;
  
  //to make sure I make the right decision about adding or subracting the nec.
  //change in value, I need to check whether I am [currently moving from the
  //starting color to the destination color] or if it's vice versa.
  red_change = (frame_counter < (glow_frame_period / 2)) ? red_change : 
                                                      -1 * red_change;
  green_change = (frame_counter < (glow_frame_period / 2)) ? green_change : 
                                                      -1 * green_change;
  blue_change = (frame_counter < (glow_frame_period / 2)) ? blue_change : 
                                                      -1 * blue_change;
  
  float new_red = red(start_color) + (frame_counter * red_change);
  float new_green = green(start_color) + (frame_counter * green_change);
  float new_blue = blue(start_color) + (frame_counter * blue_change);
  
  //increment the frame_counter
  frame_counter = (frame_counter < (glow_frame_period / 2)) ? frame_counter += 1 : 1;
  if (frame_counter % 10 == 0) { print(str(red_change) + "\n"); }
  
  return color(new_red, new_green, new_blue);
}
