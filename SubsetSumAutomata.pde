// TODO
//    - Only store a mapping the second time it's requested? Or only have a chance to store each?
//    - Symmetrical soups!

import java.util.HashSet;

import gifAnimation.*;

// Simulation.
int WIDTH = 100, HEIGHT = WIDTH;
int[][] cells = new int[WIDTH][HEIGHT];
boolean AUTO_RESET = true;

// Display.
int FRAMERATE = 30;
int CELL_SIZE = 10, BORDER_SIZE = 0;
boolean SHOW_NUMBERS = false, HIDE_ZEROS = false;

// Tracking.
int highest = 0;
static int queries = 0, hits = 0;
GifMaker gifExport;
HashSet<String> seen = new HashSet<String>();

// Gifs.
boolean GIF_MODE = false;
int GIF_FRAMES = 200;
String GIF_FILENAME = "1";
int GIF_HYPERSPEED = 1;

// Pulsars.
Automaton automaton = new NSumAutomaton(3, 1, 1, Automaton.NEIGHBORS_ALL, 0, 0, 6, true);
// Whorls. Target = 2 for diamond whorls, 3 for octagonal whorls, 4 for wave-like whorls, higher for general oceanea.
//Automaton automaton = new NSumAutomaton(3, 1, 100, Automaton.NEIGHBORS_ALL, 0, 0, 5, true);
// Eventual diagonal medium, leads to complex loops.
//Automaton automaton = new NSumAutomaton(4, 9, 5, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 7, true);
// Puffers and spreading patterns. initGliderGunSeed() is for this. A messier of this naturally arises from a 100x100 toroid seeded with a 2x2 square of 3s.
//Automaton automaton = new NSumAutomaton(3, 5, 7, Automaton.NEIGHBORS_ALL, 0, 0, 3, true);
// Rainbow diamonds.
//Automaton automaton = new NSumAutomaton(9, 9, 8, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 7, true);
// Orthogonal puffers with divergent clumps.
//Automaton automaton = new NSumAutomaton(2, 3, 4, Automaton.NEIGHBORS_ALL, 0, 0, 2, true);
// Mandala (use 2-square seed).
//Automaton automaton = new NSumAutomaton(4, 3, 4, Automaton.NEIGHBORS_ALL, 0, 0, 1, true);
// Noise.
//Automaton automaton = new NSumAutomaton(2, 3, 2, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 5, true);
// Undulating waves with occasional spikes, then large divergent crystals.
//Automaton automaton = new NSumAutomaton(3, 1, 2, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 5, true);
// Rectangularly segmented whorls. Some of these whorls veeeeery slowly diverge.
//Automaton automaton = new NSumAutomaton(1, 1, 8, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 5, true);
// Rectangular checkerboard regions, and -- very rarely -- some stuff that can live in that medium.
//Automaton automaton = new NSumAutomaton(6, 3, 5, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 4, true);
// 22.5 degree shards.
//Automaton automaton = new NSumAutomaton(4, 3, 5, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 4, true);
// One in every 10 times, spawns one of a few types of high-value glider.
//Automaton automaton = new NSumAutomaton(11, 4, 9, Automaton.NEIGHBORS_ALL, 0, 0, 5, true);
// More varieties of high-value glider. Even more with NEIGHBORS_ALL_AND_SELF. +8/5/12 has some too.
//Automaton automaton = new NSumAutomaton(5, 4, 7, Automaton.NEIGHBORS_ALL, 0, 0, 5, true);
// Tight rainbow whorls. The higher the penalty, the tighter the spiral.
//Automaton automaton = new NSumAutomaton(6, 3, 8, Automaton.NEIGHBORS_ORTHOGONAL_AND_SELF, 0, 0, 3, true);
// Tons of tiny gliders (and wacky gliding glider guns using initSelfReplicatingSeed()?!)
//Automaton automaton = new NSumAutomaton(10, 3, 11, Automaton.NEIGHBORS_ALL_AND_SELF, 0, 0, 3, true);
// Seething maze-like growths.
//Automaton automaton = new NSumAutomaton(7, 1, 1, Automaton.NEIGHBORS_ALL_AND_SELF, 0, 0, 1, false);
// Crazy rainbow X (use 3-square seed).
//Automaton automaton = new NSumAutomaton(3, 3, 4, Automaton.NEIGHBORS_ALL_AND_SELF, 0, 0, 1, false);
// Orthog/diag explosions (use 1-square seed).
//Automaton automaton = new NSumAutomaton(1, 1, 2, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 5, true);
// "Swimmer" loop (use 4-square seed).
//Automaton automaton = new NSumAutomaton(8, 4, 9, Automaton.NEIGHBORS_ALL_AND_SELF, 0, 0, 1, false);
// A bunch of somewhat rare and super funky gliders.
//Automaton automaton = new NSumAutomaton(3, 2, 3, Automaton.NEIGHBORS_ORTHOGONAL_AND_SELF, 0, 0, 2, true);
// Spazzy, staticky mandala (use 2-square seed).
//Automaton automaton = new NSumAutomaton(4, 3, 4, Automaton.NEIGHBORS_ALL, -10000, 0, 1, true);
// Diagonal waves.
//Automaton automaton = new NSumAutomaton(10, 7, 4, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 7, true);
// Very cool, very complex diagonal gliders. Strangely similar behavior with any 1/N+1/N for sufficiently high values of N. Gets sparser the higher N gets.
//Automaton automaton = new NSumAutomaton(1, 7, 6, Automaton.NEIGHBORS_ALL, 0, 0, 5, true);
// Striated waves.
//Automaton automaton = new NSumAutomaton(2, 5, 8, Automaton.NEIGHBORS_ALL, 0, 0, 10, true);
// Churn.
//Automaton automaton = new NSumAutomaton(8, 1, 999999, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Flickering, spreading, maze gradients.
//Automaton automaton = new NSumAutomaton(8, 5, 11, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Roiling regions.
//Automaton automaton = new NSumAutomaton(9, 1, 15, Automaton.NEIGHBORS_ALL, 0, 0, 3, true);
// Rare large-ish oscillators. Works with penalty 6-8, 6 being the most dense.
//Automaton automaton = new NSumAutomaton(9, 2, 7, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Fading chunks (+9/4/5 works as well, but fades much faster).
//Automaton automaton = new NSumAutomaton(9, 5, 4, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// More varieties of oscillator.
//Automaton automaton = new NSumAutomaton(9, 4, 6, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Life-like, evolving mass with steady density.
//Automaton automaton = new NSumAutomaton(9, 4, 7, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Gliders, both of the regular variety and the wide-rainbow-stripe variety. (What is the ultra-common diagonally symmetrical pulse pattern that happens if max init val is set to 3?)
//Automaton automaton = new NSumAutomaton(9, 5, 6, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Expanding roil.
//Automaton automaton = new NSumAutomaton(9, 5, 7, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Rare high-period diagonal gliders.
//Automaton automaton = new NSumAutomaton(9, 5, 11, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Rare expanding plaques that eventually disintegrate. Frequent pentadecathlon-lookin' things that aren't actually oscillators and just die.
//Automaton automaton = new NSumAutomaton(9, 6, 5, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Rare diagonal gliders.
//Automaton automaton = new NSumAutomaton(9, 6, 7, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Chaotic medium with empty regions.
//Automaton automaton = new NSumAutomaton(9, 7, 6, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Diagonal gliders and simple oscillators. 9/8/15 works much the same.
//Automaton automaton = new NSumAutomaton(9, 7, 12, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Lots of different types of oscillators.
//Automaton automaton = new NSumAutomaton(9, 8, 4, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Quartercircular waves.
//Automaton automaton = new NSumAutomaton(9, 10, 7, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Gliders, puffers, glider guns. Somehow related to +3/5/7?!
//Automaton automaton = new NSumAutomaton(1, 23, 5, Automaton.NEIGHBORS_ALL, 0, 0, 4, true);
// Growing mazes with rippling subgradients.
//Automaton automaton = new NSumAutomaton(13, 11, 15, Automaton.NEIGHBORS_ALL, 0, 0, 10, true);
// Conduit.
//Automaton automaton = new NSumAutomaton(2, 1, 4, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 1, true);
// A couple interesting types of orthogonal spaceship.
//Automaton automaton = new NSumAutomaton(3, 1, 6, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 2, true);
// Stitch fill.
//Automaton automaton = new NSumAutomaton(3, 1, 5, Automaton.NEIGHBORS_ORTHOGONAL, 0, 0, 2, true);
// Strange wave collisions.
//Automaton automaton = new NSumAutomaton(2, 1, 100000, Automaton.NEIGHBORS_ORTHOGONAL_AND_SELF, 0, 0, 2, false);
// Mold.
//Automaton automaton = new NSumAutomaton(13, 1, 0, Automaton.NEIGHBORS_ALL, 0, 0, 2, true);
// Oblique waves and orth+diag spaceships.
//Automaton automaton = new NSumAutomaton(21, 19, 12, Automaton.NEIGHBORS_ALL, 0, 0, 5, true);

void setup() {
  if (GIF_MODE) {
    CELL_SIZE = 1;
    SHOW_NUMBERS = false;
  }

  int width = WIDTH * CELL_SIZE + (WIDTH + 1) * BORDER_SIZE;
  int height = HEIGHT * CELL_SIZE + (HEIGHT + 1) * BORDER_SIZE;
  surface.setSize(width, height);
  frameRate(FRAMERATE);
  colorMode(HSB, 1);
  noStroke();

  textAlign(CENTER, CENTER);
  if (SHOW_NUMBERS) {
    PFont font = createFont("beleren-bold.ttf", CELL_SIZE / 2);
    textFont(font);
  }

  automaton.init(cells);
  //initSquareSeed(2);
  //initSelfReplicatingSeed();
  //initGliderGunSeed();
  //initTestSeed();

  if (GIF_MODE) {
    gifExport = new GifMaker(this, GIF_FILENAME + ".gif", 1);
    gifExport.setRepeat(0); // make it an "endless" animaton
    gifExport.setDelay(1000/24);  //24fps in ms
  }
}

void draw() {
  if (frameCount % 100 == 2) {
    println("Cache hits at " + (hits/(float)queries*100) + "%.");
  }

  background(automaton.colorMap(0));
  for (int x = 0; x < WIDTH; x++) {
    for (int y = 0; y < HEIGHT; y++) {
      fill(automaton.colorMap(cells[x][y]));
      int px = x * CELL_SIZE + (x + 1) * BORDER_SIZE;
      int py = y * CELL_SIZE + (y + 1) * BORDER_SIZE;
      if (cells[x][y] > 0) {
        rect(px, py, CELL_SIZE, CELL_SIZE);
      }
      if (SHOW_NUMBERS && (cells[x][y] > 0 || !HIDE_ZEROS)) {
        fill(0);
        text(str(cells[x][y]), px + CELL_SIZE / 2, py + CELL_SIZE * .4375);
      }

      if (cells[x][y] > highest) {
        highest = cells[x][y];
        println("New highest: " + highest + "!");
      }
    }
  }
  automaton.iterate(cells);

  if (AUTO_RESET && allZero()) {
    println("Dead, resetting...");
    setup();
  }

  if (gifExport != null) {
    if (frameCount % GIF_HYPERSPEED != 0) {
      return;
    }

    gifExport.addFrame();

    if (frameCount == GIF_FRAMES * GIF_HYPERSPEED) {
      gifExport.finish();
      exit();
    }
  }
}

public void keyPressed()
{
  if (key == 'r')
    setup();
}

// JUNK

void initTestSeed() {
  int cx = 4, cy = 4;

  cells[cx][cy] = 100;
  cells[cx+1][cy] = 103;
  cells[cx][cy+1] = 106;
  cells[cx+1][cy+1] = 109;
}

void initSquareSeed(int val) {
  int cx = cells.length / 2, cy = cells[0].length / 2;
  cells[cx-1][cy-1] = val;
  cells[cx][cy-1] = val;
  cells[cx-1][cy] = val;
  cells[cx][cy] = val;
}

void initSelfReplicatingSeed() {
  int cx = 3, cy = cells[0].length - 4;
  cells[cx][cy] = 10;
  cells[cx+1][cy] = 10;
  cells[cx+2][cy] = 10;
  cells[cx+1][cy+1] = 20;
  cells[cx+3][cy+1] = 10;
  cells[cx+2][cy+2] = 2;
}

void initGliderGunSeed() {
  int cx = cells.length / 2, cy = cells[0].length / 2 - 13;

  // Top seed crystal.
  cells[cx][cy] = 100;
  cells[cx+1][cy] = 103;
  cells[cx][cy+1] = 106;
  cells[cx+1][cy+1] = 109;
  // Top extension.
  cells[cx-1][cy+2] = 3;
  cells[cx][cy+2] = 3;
  cells[cx+1][cy+2] = 3;
  // Top repeater crystal.
  cells[cx-3][cy+6] = 100;
  cells[cx-2][cy+6] = 103;
  cells[cx-3][cy+7] = 106;
  cells[cx-2][cy+7] = 109;

  // Bottom repeater crystal.
  cells[cx-3][cy+16] = 100;
  cells[cx-2][cy+16] = 103;
  cells[cx-3][cy+17] = 106;
  cells[cx-2][cy+17] = 109;
  // Bottom extension.
  cells[cx-1][cy+21] = 3;
  cells[cx][cy+21] = 3;
  cells[cx+1][cy+21] = 3;
  // Bottom seed crystal.
  cells[cx][cy+22] = 100;
  cells[cx+1][cy+22] = 103;
  cells[cx][cy+23] = 106;
  cells[cx+1][cy+23] = 109;
}

boolean allZero() {
  for (int x = 0; x < cells.length; x++) {
    for (int y = 0; y < cells[0].length; y++) {
      if (cells[x][y] != 0) {
        return false;
      }
    }
  }
  return true;
}