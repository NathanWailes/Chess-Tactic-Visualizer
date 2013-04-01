//*********************THIS LINE IS 80 CHARACTERS LONG**************************
PImage img;
//I need screen_width/height to initialize the board size
int screen_width = 1280;
int screen_height = 640;
//I need Chess global to access its stuff across multiple frames
ChessGame Chess = new ChessGame("2D Chess");
int target_frameRate = 30; //alternateColors() needs target_frameRate
String CurrentScreen = "Menu";

void setup() {
  size(screen_width, screen_height);
  frameRate(target_frameRate);
}

void draw() {
  if (CurrentScreen == "Menu") {
    background(0);
    DrawMenu();
  } else if (CurrentScreen == "In Game") {
    background(0);
    Chess.updateMouseHover(mouseX, mouseY);
    DrawChessboard();
    DrawPieces();
  }
}

void mousePressed() {
  if (CurrentScreen == "Menu") {
    //Menu.ProcessClick();
  } else if (CurrentScreen == "In Game") {
    Chess.ProcessSquareClick();
  }
}

void keyPressed() {
  if (key=='1'){
    CurrentScreen = "Menu";
  } else if (key=='2' && (Chess.Boards[0].Squares != null)){
    CurrentScreen = "In Game";
  } else if (key=='3'){
    Chess.New2DGame();
    CurrentScreen = "In Game";
  }
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

