//I'm thinking I'll have a "game" class that will have one or more boards
//depending on whether the player is playing regular chess, 3D chess, or 4D
//chess.  I want to have an option for the player to switch game type.
class ChessGame {
  Board[] Boards;
  
  Square selected_square;
  Square null_square;
  Piece null_piece = new Piece('N', 'N', new int[]{-1, -1});
  
  // an array of type Piece; the array's named Pieces
  Piece[] Pieces;
  
  char player_to_move = 'W';
  
  color white_player_color = color(0, 0, 150);
  color black_player_color = color(150, 0, 0);
  
  //the below variables are used to make a square glow with alternateColors()
  color glow_color = color(243, 255, 0);
  int glow_period_in_seconds = 2;
  
  void New2DGame(){
   ChessGame Chess = new ChessGame("2D Chess");
   InitializePieces();
   InitializeSquares();
   return;
  }
  
  ChessGame(String GameType){
    if (GameType == "2D Chess") {
      Boards = new Board[1];
      Boards[0] = new Board("2D Chess");
    }
  }

  void updateMouseHover(int x, int y) {
    Square[] Squares = Chess.Boards[0].Squares;
    for (int i=0; i < Squares.length; i++) {
      float square_side = Chess.Boards[0].square_side;
      if ( overRect(Squares[i].screen_location[0], 
           Squares[i].screen_location[1],
           square_side, square_side) ) {
        Squares[i].hovered_over = true;
      } else {
        Squares[i].hovered_over = false;
      }
    }
  }
  
  void SwitchTurns() {
    if (player_to_move == 'W') {
      player_to_move = 'B';
    } else {
      player_to_move = 'W';
    }
  }
  
  void ProcessSquareClick() {
    Square[] Squares = Boards[0].Squares; //making a shorter name for Boards[0].Squares
    for (int i=0; i < Squares.length; i++) {
      float square_side = Boards[0].square_side;
      if ( overRect(Squares[i].screen_location[0],
                    Squares[i].screen_location[1],
                    square_side, square_side) ) {
        //deselect the square if it was already selected
        if (Squares[i].selected == true) {
          Boards[0].Squares[i].selected = false;
          selected_square = null_square;
        //select the square if it wasn't selected
        } else if ((selected_square == null_square) &&
                   (Squares[i].selected == false)) {
          selected_square = Squares[i];
          Squares[i].selected = true;
        //if a piece is selected and it isn't that side's turn to move,
        //don't do anything.
        } else if ((selected_square.occupying_piece != null_piece) &&
                   (Chess.player_to_move != selected_square.occupying_piece.side)){
          return;
        //if a piece is selected already, move it to the current square
        } else if ((selected_square.occupying_piece != null_piece) /*&& 
                   (Squares[i].occupying_piece.MoveAllowed(Squares[i]))*/
                   ) {
          selected_square.occupying_piece.Move(i);
          //switch whose turn it is
          Chess.SwitchTurns();
        }
      }
    }
  } //end of ProcessSquareClick()

  //return the square's index in the array given its board_location
  int GetSquare(int[] board_location) {
    int desired_square_index = 0;
    for (int i=0; i<Chess.Boards[0].Squares.length; ++i) {
      
      if ((Chess.Boards[0].Squares[i].board_location[0] == board_location[0]) &&
         (Chess.Boards[0].Squares[i].board_location[1] == board_location[1])) {
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
        Square[] squares = Chess.Boards[0].Squares;
        
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
} //end of the ChessGame class
