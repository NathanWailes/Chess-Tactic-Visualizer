//*********************THIS LINE IS 80 CHARACTERS LONG**************************

//I want to get these variables to not be global ASAP
float glow_color = 255;
float increment = 9;

PImage img;

//I need global screen_width/height vars b/c the Board class uses the width and
//height of the screen to set the x/y pos of the board.  And the Board class is
//initialized BEFORE the size() function sets the width/height.
int screen_width = 640;
int screen_height = 360;

//I need this to be global b/c I need to access the stuff formed here both in
//the setup() and draw() functions.
Game Chess = new Game();

void setup() {
  size(screen_width, screen_height);
  frameRate(30);
  PFont f = loadFont("Arial-BoldMT-10.vlw");
  textFont(f,16);
  
  InitializePieces();
  InitializeSquares();
}

void draw() {
  background(0);
  update(mouseX, mouseY);

  DrawChessboard();
  DrawPieces();
  DrawMenu();
  
} //end of draw() function


void update(int x, int y) {
  Square[] Squares = Chess.Board.Squares;
  for (int i=0; i < Squares.length; i++) {
    float square_side = Chess.Board.square_side;
    if ( overRect(Squares[i].screen_location[0], 
         Squares[i].screen_location[1],
         square_side, square_side) ) {
      Squares[i].hovered_over = true;
    } else {
      Squares[i].hovered_over = false;
    }
  }
}
boolean overRect(float x, float y, float width, float height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() {
  //check if any squares were clicked on, and if so, take appropriate action
  Chess.ProcessSquareClick();
}

//*********************THIS LINE IS 80 CHARACTERS LONG**************************
//*********************THIS LINE IS 80 CHARACTERS LONG**************************

/*
Ideas:
 - make the relative size of the pieces depend on their worth; eg if the queen
   is worth 9 and a pawn is only worth 1, make the queen 9 times bigger than
   the pawn. Or have it as an option to toggle between this view and the normal
   view.
 - make a 3D or 4D "Heaven vs. Hell" game, where the color of the pieces and 
   squares makes it look appropriate.  For example, white or gold pieces for 
   heaven, red or black pieces for hell, green squares for the "earth" board,
   black or red squares for the "hell" board, gold squares for the "heaven"
   board)
*/

