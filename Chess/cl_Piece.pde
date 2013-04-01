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
    Square destination_square = Chess.Boards[0].Squares[i];
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
