//I'm thinking I'll have a "game" class that will have one or more boards
//depending on whether the player is playing regular chess, 3D chess, or 4D
//chess.  I want to have an option for the player to switch game type.
class Game {
  Board Board = new Board();
  
  Square selected_square;
  Square null_square;
  Piece null_piece = new Piece('N', 'N', new int[]{-1, -1});
  
  // an array of type Piece; the array's named Pieces
  Piece[] Pieces;
  
  color white_player_color = color(0, 0, 150);
  color black_player_color = color(150, 0, 0);
  
  //the below variables are used to make a square glow with alternateColors()
  color glow_color = color(243, 255, 0);
  int glow_period_in_seconds = 2;
  
  void ProcessSquareClick() {
    Square[] Squares = Board.Squares; //making a shorter name for Board.Squares
    for (int i=0; i < Squares.length; i++) {
      float square_side = Board.square_side;
      if ( overRect(Squares[i].screen_location[0],
                    Squares[i].screen_location[1],
                    square_side, square_side) ) {
        //deselect the square if it was already selected
        if (Squares[i].selected == true) {
          Board.Squares[i].selected = false;
          selected_square = null_square;
        //select the square if it wasn't selected
        } else if ((selected_square == null_square) &&
                   (Squares[i].selected == false)) {
          selected_square = Squares[i];
          Squares[i].selected = true;
        //if a piece is selected already, move it to the current square
        } else if ((selected_square.occupying_piece != null_piece) /*&& 
                   (Squares[i].occupying_piece.MoveAllowed(Squares[i]))*/
                   ) {
          selected_square.occupying_piece.Move(i);
        }
      }
    }
  } //end of ProcessSquareClick()

  //return the square's index in the array given its board_location
  int GetSquare(int[] board_location) {
    int desired_square_index = 0;
    for (int i=0; i<Chess.Board.Squares.length; ++i) {
      
      if ((Chess.Board.Squares[i].board_location[0] == board_location[0]) &&
         (Chess.Board.Squares[i].board_location[1] == board_location[1])) {
           desired_square_index = i;
      }
    }
    return desired_square_index;
  }

  boolean LegalPawnMove(Piece moving_piece, Square destination_square, 
                        Piece[] Pieces) {
    int piece_x = moving_piece.board_location[0];
    int piece_y = moving_piece.board_location[1];
    int square_x = destination_square.board_location[0];
    int square_y = destination_square.board_location[1];
    
    if ((abs(piece_x - square_x) == 0) && (abs(piece_y - square_y) == 1)){
      return true;
    } else {
      return false;
    }
  }

  boolean LegalKnightMove(Piece moving_piece, Square destination_square, 
                        Piece[] Pieces) {
    int piece_x = moving_piece.board_location[0];
    int piece_y = moving_piece.board_location[1];
    int square_x = destination_square.board_location[0];
    int square_y = destination_square.board_location[1];
    
    if (((abs(piece_x - square_x) == 2) && (abs(piece_y - square_y) == 1)) ||
        ((abs(piece_y - square_y) == 2) && (abs(piece_x - square_x) == 1))){
      return true;
    } else {
      return false;
    }
  }

  boolean LegalBishopMove(Piece moving_piece, Square destination_square, 
                        Piece[] Pieces) {
    int piece_x = moving_piece.board_location[0];
    int piece_y = moving_piece.board_location[1];
    int square_x = destination_square.board_location[0];
    int square_y = destination_square.board_location[1];
    
    if (abs(piece_x - square_x) == abs(piece_y - square_y)) {
      return true;
    } else {
      return false;
    }
  }
    
    /*
    //if the piece is on the same file as its destination square:
    if (abs(piece_x - square_x) == 0) {
      //go square-by-square from the queen's pos to the dest square to look for
      //other pieces
      
      //if the square is closer to white's side than the queen...
      
      int i = 1;
      while (i <= abs(piece_x - square_x)) {
        int interm_square_index = GetSquare(new int[] {piece_x,piece_y + i});
        int s = interm_square_index;//a nickname b/c it's shorter
        Square[] squares = Chess.Board.Squares;
        
        if (squares[s].occupying_piece != Chess.null_piece) {
          print(squares[s].name);
          return false;
        }
        i = (square_y > piece_y) ? i+1 : i-1;
      }
      
      return false;
    } else {
      return true;
    }*/
  boolean LegalRookMove(Piece moving_piece, Square destination_square, 
                        Piece[] Pieces) {
    int piece_x = moving_piece.board_location[0];
    int piece_y = moving_piece.board_location[1];
    int square_x = destination_square.board_location[0];
    int square_y = destination_square.board_location[1];
    
    if (abs(piece_x - square_x) == 0) {
      return true;
    } else if (abs(piece_y - square_y) == 0) {
      return true;
    } else {
      return false;
    }
  }

  boolean LegalQueenMove(Piece moving_piece, Square destination_square, 
                        Piece[] Pieces) {
    if (LegalBishopMove(moving_piece, destination_square, Pieces) ||
        LegalRookMove(moving_piece, destination_square, Pieces)) {
      return true;
    } else {
      return false;
    }
  }

  boolean LegalKingMove(Piece moving_piece, Square destination_square, 
                        Piece[] Pieces) {
    int piece_x = moving_piece.board_location[0];
    int piece_y = moving_piece.board_location[1];
    int square_x = destination_square.board_location[0];
    int square_y = destination_square.board_location[1];
    
    if ((abs(piece_x - square_x) <= 1) && (abs(piece_y - square_y) <= 1)) {
      return true;
    } else {
      return false;
    }
  }


} //end of the Game class

//if the player is playing 3D/4D chess there will be multiple boards, each with
//their own x and y coordinates.
class Board {
  int board_x, board_y;
  float board_width = 300, board_height = 300;
  float square_side = board_width / 8;
  Square[] Squares;
  
  //if I make 3D / 4D chess I may want
  //to have different boards be different colors to reflect their different
  //dimensions
  color black_square_color = color(0, 110, 0);
  color white_square_color = color(255, 255, 255);
  color square_selected_color = color(243, 255, 0);
  color square_border_color = color(0, 0, 0);
  
  Board() {
    board_x = int(screen_width * 0.25);
    board_y = int(screen_height * 0.1);
  }
}

class Piece {
  char side = 'W'; //white or black piece
  char type = 'P'; //every piece has a type (eg pawn, queen)
  int[] board_location = new int[] {0, 0}; // (eg h4, g7)
  Square[] possible_moves;
  
  Piece(char _side, char _type, int[] _board_location) {
    side = _side;
    type = _type;
    board_location = _board_location;
  }
  
  Square[] get_possible_moves(Square[] all_squares) {
    Square[] possible_moves = {};
    for (int i=0; i < all_squares.length; ++i) {
      //the "this" below refers to the piece that is running this method
      if (this.MoveAllowed(all_squares[i])) {
        append(possible_moves, all_squares[i]);
      }
    }
    return possible_moves;
  }
  
  boolean MoveAllowed(Square destination_square) {
    //I need to check:
    // 1) does the player have another piece there already?
    // 2) if not, can that piece legally move to that square?
    
    //figure out what piece is at the destination
    Piece occupying_piece;
    for (int i=0; i<Chess.Pieces.length; ++i) {
      int piece_x = Chess.Pieces[i].board_location[0];
      int piece_y = Chess.Pieces[i].board_location[1];
      int square_x = destination_square.board_location[0];
      int square_y = destination_square.board_location[1];
      
      if (piece_x == square_x && piece_y == square_y) {
        occupying_piece = Chess.Pieces[i];
      }
    }
    
    
    if (destination_square.occupying_piece.side == this.side) {
      return false;
    } else if (this.type == 'P') {
      return Chess.LegalPawnMove(this, destination_square, Chess.Pieces)
             ? true : false;
    } else if (this.type == 'N') {
      return Chess.LegalKnightMove(this, destination_square, Chess.Pieces)
             ? true : false;
    } else if (this.type == 'B') {
      return Chess.LegalBishopMove(this, destination_square, Chess.Pieces)
             ? true : false;
    } else if (this.type == 'R') {
      return Chess.LegalRookMove(this, destination_square, Chess.Pieces)
             ? true : false;
    } else if (this.type == 'Q') {
      return Chess.LegalQueenMove(this, destination_square, Chess.Pieces)
             ? true : false;
    } else if (this.type == 'K') {
      return Chess.LegalKingMove(this, destination_square, Chess.Pieces)
             ? true : false;
    }
    
    return false;
  }
  
  void Move(int destination_square_index) {
    int i = destination_square_index; //renaming it to be shorter
    
    //I think these are making copies of the objects...I'm not sure though.
    Square destination_square = Chess.Board.Squares[i];
    Square selected_square = Chess.selected_square;
    Piece null_piece = Chess.null_piece;
    
    if ((destination_square.occupying_piece == null_piece) &&
       this.MoveAllowed(destination_square)) {
      selected_square.occupying_piece.board_location = 
                                              destination_square.board_location;
      destination_square.occupying_piece = selected_square.occupying_piece;
      selected_square.occupying_piece = null_piece;
    //if there's an opponent's piece there already, then
      //remove the opponent's piece, set it to "captured"
      //move the selected piece to that square
    } else {
      
    }
    //deselect the selected square automatically
    Chess.selected_square.selected = false;
    Square null_square = Chess.null_square;
    Chess.selected_square = null_square;
  } // end of Move()

}//end of class Piece

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
