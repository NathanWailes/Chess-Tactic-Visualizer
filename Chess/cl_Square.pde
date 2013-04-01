class Square {
  String name; //the name of the square (eg h4, g7)
  //board_location is used for calculating moves of pieces; range: 0,0 to 8,8
  int[] board_location = new int[] {0, 0};
  //screen_location holds the pixel coordinates for drawing the square
  float[] screen_location = new float[] {0, 0};
  color default_square_color;
  color current_square_color;
  Piece occupying_piece = Chess.null_piece; //i may end up not using this
  boolean hovered_over; //tracks whether the mouse is hovering over the square
  boolean selected = false;
  int glow_loop_progress = 1; //an int from 1 to 100 used to make the square
                              //glow brighter and darker.
  
  Square(String _name, int[] _board_location,
         float[] _screen_location, color _default_square_color ) {
    name = _name;
    board_location = _board_location;
    screen_location = _screen_location;
    default_square_color = _default_square_color;
    current_square_color = default_square_color;
    //the loop below checks to see if any pieces are on the square.
    Piece[] Pieces = Chess.Pieces;
    for (int p = 0; p < Pieces.length; p++) {
      if ((Pieces[p].board_location[0] == board_location[0]) &&
          (Pieces[p].board_location[1] == board_location[1])) {
            occupying_piece = Pieces[p];
      }
    }
    Piece null_piece = Chess.null_piece;
    if (name == "null_square") { occupying_piece = null_piece; }
  }
} //end of class Square
