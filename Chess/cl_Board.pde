//if the player is playing 3D/4D chess there will be multiple boards, each with
//their own x and y coordinates.
class Board {
  int board_x, board_y;
  float board_side;
  float square_side;
  color black_square_color;
  color white_square_color;
  color square_selected_color;
  Square[] Squares;
  
  Board(String GameType) {
    if (GameType == "2D Chess") {
      board_side = 500;
      board_x = int((screen_width/2) - (board_side/2));
      board_y = int(screen_height / 10);
      square_side = board_side / 8;
      black_square_color = color(0, 110, 0);
      white_square_color = color(255, 255, 255);
      square_selected_color = color(243, 255, 0);
    }
    if (GameType == "3D Chess") {
      board_side = 100;
      board_x = int((screen_width/2) - (board_side/2));
      board_y = int(screen_height / 10);
      square_side = board_side / 8;
      black_square_color = color(0, 110, 0);
      white_square_color = color(255, 255, 255);
      square_selected_color = color(243, 255, 0);
    }
  }
}
