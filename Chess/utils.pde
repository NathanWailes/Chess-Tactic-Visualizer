boolean overRect(float x, float y, float width, float height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

float getColorChannel(color c, int channel) {
  if (channel == 0) {
    return red(c);
  } else if (channel == 1) {
    return green(c);
  } else {
    return blue(c);
  }
}

color insertIntoColor(color c, int channel, float insertion) {
  if (channel == 0) {
    return color(insertion, green(c), blue(c));
  } else if (channel == 1) {
    return color(red(c), insertion, blue(c));
  } else {
    return color(red(c), green(c), insertion);
  }
}

color alternateColors(color start_color, color dest_color, 
                      int period_in_seconds,
                      int target_frameRate) {
  float glow_period_in_frames = int(target_frameRate * period_in_seconds);
  float current_position_in_the_period = frameCount % glow_period_in_frames;
  color updated_color = color(0,0,0);
  for (int chnl=0; chnl<=2; ++chnl) { //loop through updated_color
    int channel_start = int(getColorChannel(start_color, chnl));
    int channel_dest = int(getColorChannel(dest_color, chnl));
    int total_change = channel_dest - channel_start;
    float adjustment;
    float fraction_complete = current_position_in_the_period /
                              glow_period_in_frames;
    if (current_position_in_the_period < (glow_period_in_frames / 2)) {
      float first_half_adjustment = fraction_complete * 2;
      adjustment = total_change * first_half_adjustment;
    } else {
      float second_half_adjustment = ((-2 * fraction_complete) + 2);
      adjustment = total_change * second_half_adjustment;
    }
    float updated_channel = channel_start + adjustment;
    updated_color = insertIntoColor(updated_color, chnl, updated_channel);
  }
  return updated_color;
}

