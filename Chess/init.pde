
void InitializePieces () {
  //load the images of the different types of pieces
  img = loadImage("black_king.png");
  
  //set up which pieces are on the board and where they are
  Chess.Pieces = new Piece[32];
  Piece[] Pieces = Chess.Pieces;
  Pieces[0] = new Piece('B', 'P', new int[]{0, 1});
  Pieces[1] = new Piece('B', 'P', new int[]{1, 1});
  Pieces[2] = new Piece('B', 'P', new int[]{2, 1});
  Pieces[3] = new Piece('B', 'P', new int[]{3, 1});
  Pieces[4] = new Piece('B', 'P', new int[]{4, 1});
  Pieces[5] = new Piece('B', 'P', new int[]{5, 1});
  Pieces[6] = new Piece('B', 'P', new int[]{6, 1});
  Pieces[7] = new Piece('B', 'P', new int[]{7, 1});
  
  Pieces[8] = new Piece('B', 'R', new int[]{0, 0});
  Pieces[9] = new Piece('B', 'N', new int[]{1, 0});
  Pieces[10] = new Piece('B', 'B', new int[]{2, 0});
  Pieces[11] = new Piece('B', 'Q', new int[]{3, 0});
  Pieces[12] = new Piece('B', 'K', new int[]{4, 0});
  Pieces[13] = new Piece('B', 'B', new int[]{5, 0});
  Pieces[14] = new Piece('B', 'N', new int[]{6, 0});
  Pieces[15] = new Piece('B', 'R', new int[]{7, 0});
  
  Pieces[16] = new Piece('W', 'P', new int[]{0, 6});
  Pieces[17] = new Piece('W', 'P', new int[]{1, 6});
  Pieces[18] = new Piece('W', 'P', new int[]{2, 6});
  Pieces[19] = new Piece('W', 'P', new int[]{3, 6});
  Pieces[20] = new Piece('W', 'P', new int[]{4, 6});
  Pieces[21] = new Piece('W', 'P', new int[]{5, 6});
  Pieces[22] = new Piece('W', 'P', new int[]{6, 6});
  Pieces[23] = new Piece('W', 'P', new int[]{7, 6});
  
  Pieces[24] = new Piece('W', 'R', new int[]{0, 7});
  Pieces[25] = new Piece('W', 'N', new int[]{1, 7});
  Pieces[26] = new Piece('W', 'B', new int[]{2, 7});
  Pieces[27] = new Piece('W', 'Q', new int[]{3, 7});
  Pieces[28] = new Piece('W', 'K', new int[]{4, 7});
  Pieces[29] = new Piece('W', 'B', new int[]{5, 7});
  Pieces[30] = new Piece('W', 'N', new int[]{6, 7});
  Pieces[31] = new Piece('W', 'R', new int[]{7, 7});
  
  Piece null_piece = new Piece('N', 'N', new int[]{-1, -1});
} //end of InitializePieces()  

void InitializeSquares () {
  Chess.Board.Squares = new Square[64];
  float square_x;
  float square_y;
  color square_color;
  String name;
  int index_num;
  int[] board_location;
  float[] screen_location;
  String[] col_names = {"a", "b", "c", "d", "e", "f", "g", "h"};
  for (int row = 0; row < 8; row = row+1) {
    for (int col = 0; col < 8; col = col+1) {
      //generates the typical name for a square, eg h4 or g6
      name = col_names[col] + str(8-(row));
      //determining the square's array-index-number (in the Squares[] array)
      //for example the top left square's # will be 0, the bottom right is 63
      index_num = (row * 8) + col;
      //range: 0,0 to 8,8 starting from the top left of the board
      board_location = new int[] {col, row};
      //determining the square's screen location (ie the pixel coordinates)
      square_x = Chess.Board.board_x + (col * Chess.Board.square_side);
      square_y = Chess.Board.board_y + (row * Chess.Board.square_side);
      screen_location = new float[] {square_x, square_y};
      //determining the square's color
      if (row % 2 == 0) {
        if (col % 2 == 0) {
          square_color = Chess.Board.white_square_color;
        } else {
          square_color = Chess.Board.black_square_color;
        }
      } else {
        if (col % 2 == 0) {
          square_color = Chess.Board.black_square_color;
        } else {
          square_color = Chess.Board.white_square_color;
        }
      }
      //after gathering all the necessary info, we can now initialize the square
      Chess.Board.Squares[index_num] = new Square(name, board_location, 
                                                  screen_location,
                                                  square_color);
    } //end of the column loop
  } //end of the row loop
  
  //this matches up the squares with whatever pieces are occupying it
  Piece[] Pieces = Chess.Pieces;
  for (int p = 0; p < Pieces.length; p++) {
    Square[] Squares = Chess.Board.Squares;
    for (int s = 0; s < Squares.length; s++) {
      if (Pieces[p].location[0] == Squares[s].board_location[0] &&
          Pieces[p].location[1] == Squares[s].board_location[1]) {
            Squares[s].occupying_piece = Pieces[p];
          }
    }
  }
  
  //when no square is selected i'll set the selected_square variable to this
  //square.  I couldn't figure out how to set the selected_square var to null.
  int[] a = new int[] {0,0};
  float[] b = new float[] {0, 0};
  Chess.null_square = new Square("none", new int[] {0,0}, 
                                  new float[] {0, 0}, Chess.black_player_color);
  Chess.selected_square = Chess.null_square;
} //end of InitializeSquares()

