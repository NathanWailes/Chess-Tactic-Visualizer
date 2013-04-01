void DrawChessboard() {
  Square[] Squares = Chess.Boards[0].Squares;
  for (int i = 0; i < Squares.length; i++) {
    if (Squares[i].selected == true) {
      color glow_color = alternateColors(Squares[i].default_square_color, 
                                         Chess.glow_color,
                                         Chess.glow_period_in_seconds,
                                         target_frameRate);
      fill(glow_color);
    } else {
      fill(Squares[i].current_square_color);
    }
    if (Squares[i].hovered_over == true) {
      stroke(255, 0, 0);
    } else {
      noStroke();
    }
    float square_side = Chess.Boards[0].square_side;
    rect(Squares[i].screen_location[0], Squares[i].screen_location[1], 
         square_side, square_side);
  }
} //end of DrawChessboard()

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

void DrawPieces() {
  Piece[] Pieces = Chess.Pieces;
  PFont ArialBold = loadFont("Arial-BoldMT-10.vlw");
  for (Piece i : Pieces) {
    if (i.side == 'W') {
      fill(Chess.white_player_color);
    } else {
      fill(Chess.black_player_color);
    }
    noStroke();
    float board_x = Chess.Boards[0].board_x;
    float board_side = Chess.Boards[0].board_side;
    float square_side = Chess.Boards[0].square_side;
    float piece_x = board_x + ((board_side / 8) * (i.board_location[0])) + 
                    (square_side / 3);
    float board_y = Chess.Boards[0].board_y;
    float piece_y = board_y + ((board_side / 8) * (i.board_location[1] + 1)) -
                    (square_side / 3);
    ellipse(piece_x + 7, piece_y - 5, 20, 20);
    fill(0, 0, 0);
    char piece_type = i.type;
    textFont(ArialBold,16);
    text(piece_type, piece_x, piece_y);
  }
} //end of DrawPieces()

void DrawMenu() {
  PFont BaskOldFace = loadFont("BaskOldFace-48.vlw");

  //title - Chess Tactic Visualizer
  textFont(BaskOldFace);
  textSize(48);
  fill(255, 255, 255);
  text("Chess Tactic Visualizer", (width/2) - 225, height/10);
  
  //button - new 2D Game
  stroke(255);
  fill(27, 103, 150);
  int button_width = 200;
  int button_height = 50;
  rect((width/2)-(button_width/2), 200, button_width, button_height);
} //end of DrawMenu()

