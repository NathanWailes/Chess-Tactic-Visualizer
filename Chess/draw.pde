void DrawChessboard() {

  //creating the squares on the chessboard.  I loop through
  //the rows and columns and ask whether it's an even row/col to
  //figure out if I need to color it green or white.
  stroke(Chess.Board.square_border_color); //border on the squares
  //I'm defining square_x/y here instead of within the for-loops so that I
  //don't have the computer recreating the variables 64 times every time it
  //draws the chessboard.
  Square[] Squares = Chess.Board.Squares;
  for (int i = 0; i < Squares.length; i++) {
    if (Squares[i].selected == true) {
      color glow_color = alternateColors(Squares[i].default_square_color, 
           Chess.glow_color, Chess.glow_period_in_seconds, target_frameRate);
      fill(glow_color);
      //fill(Chess.Board.square_selected_color);
    } else {
      fill(Squares[i].current_square_color);
    }
    if (Squares[i].hovered_over == true) {
      stroke(255, 0, 0);
    } else {
      noStroke();
    }
    float square_side = Chess.Board.square_side;
    rect(Squares[i].screen_location[0],Squares[i].screen_location[1], 
         square_side, square_side);
  }
} //end of DrawChessboard()

//I want this function to make the selected square glow slowly brighter and
//darker to make the board more attractive.  Maybe I could make many squares
//glow, and have them glow at different rates based on information about that
//square (eg a piece in danger glows quickly).
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

void DrawPieces() {
  Piece[] Pieces = Chess.Pieces;
  for (Piece i : Pieces) {
    if (i.side == 'W') {
      fill(Chess.white_player_color);
    } else {
      fill(Chess.black_player_color);
    }
    noStroke();
    float board_x = Chess.Board.board_x;
    float board_width = Chess.Board.board_width;
    float square_side = Chess.Board.square_side;
    float piece_x = board_x + ((board_width / 8) * (i.location[0])) + 
          (square_side / 3);
    //print(width*0.25);
    float board_y = Chess.Board.board_y;
    float board_height = Chess.Board.board_height;
    float piece_y = board_y + ((board_height / 8) * (i.location[1] + 1)) -
          (square_side / 3);
    ellipse(piece_x + 7,piece_y - 5, 20, 20);
    fill(0,0,0);
    char piece_type = i.type;
    text(piece_type,piece_x,piece_y);
    //image(img, piece_x, piece_y, img.width, img.height);
  }
} //end of DrawPieces()

void DrawMenu() {
  //need to fill this in...
} //end of DrawMenu()


