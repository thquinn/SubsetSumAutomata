interface Automaton {
  static String NEIGHBORS_ALL_AND_SELF = "111111111";
  static String NEIGHBORS_ALL = "111101111";
  static String NEIGHBORS_ORTHOGONAL = "010101010";
  static String NEIGHBORS_ORTHOGONAL_AND_SELF = "010111010";
  static String NEIGHBORS_DIAGONAL = "101000101";
  static String NEIGHBORS_T = "111000010";
  
  void init(int[][] cells);
  void iterate(int[][] cells);
  color colorMap(int value);
}