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
      fill(GlowColor());
      //fill(Chess.Board.square_selected_color);
    } else {
      fill(Squares[i].square_color);
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
color GlowColor() {
  glow_color = glow_color + increment;
  if (glow_color > 255 || glow_color < 0) {
    increment = increment * -1;
  }
  int green = 0;
  int blue = 0;
  return color(glow_color, glow_color, blue);
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


