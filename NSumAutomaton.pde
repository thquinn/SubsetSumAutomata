import java.util.Map;
import java.util.HashSet;

class NSumAutomaton implements Automaton {
  HashMap<String, HashSet<Integer>> sumMap;
  int[][] nextCells;

  int target, reward, penalty;
  String neighborMask;
  int floor;
  int minInit, maxInit;
  boolean relative;

  NSumAutomaton(int target, int reward, int penalty, String neighborMask, int floor, int minInit, int maxInit, boolean relative) {
    sumMap = new HashMap<String, HashSet<Integer>>();

    this.target = target;
    this.reward = reward;
    this.penalty = penalty;
    this.neighborMask = neighborMask;
    this.floor = floor;
    this.minInit = minInit;
    this.maxInit = maxInit;
    this.relative = relative;
  }

  void init(int[][] cells) {
    for (int x = 0; x < cells.length; x++) {
      for (int y = 0; y < cells[0].length; y++) {
        cells[x][y] = int(random(maxInit - minInit + 2) + minInit - 1);
      }
    }
  }

  void iterate(int[][] cells) {
    if (nextCells == null) {
      nextCells = new int[cells.length][cells[0].length];
    }
    
    for (int x = 0; x < cells.length; x++) {
      for (int y = 0; y < cells[0].length; y++) {
        int[] neighbors = new int[9];
        int index = 0;
        for (int dx = -1; dx <= 1; dx++) {
          for (int dy = -1; dy <= 1; dy++) {
            neighbors[index] = neighborMask.charAt(index) == '0' ? Integer.MIN_VALUE : cells[mod(x + dx, cells.length)][mod(y + dy, cells[0].length)];
            index++;
          }
        }
        boolean canSum = canSum(neighbors, target + (relative ? cells[x][y] : 0));
        if (canSum) {
          nextCells[x][y] = cells[x][y] + reward;
        } else {
          nextCells[x][y] = cells[x][y] - penalty;
        }
        if (nextCells[x][y] < floor) {
          nextCells[x][y] = floor;
        }
      }
    }
    
    for (int x = 0; x < cells.length; x++) {
      for (int y = 0; y < cells[0].length; y++) {
        cells[x][y] = nextCells[x][y];
      }
    }
  }

  color colorMap(int value) {
    //if (value <= 0) {
    //  return color(0, 0, .15);
    //}
    //float hue = sqrt(value) * .05;
    //float brightness = min(.5 + value * .025, 1);
    //return color(hue, 1, brightness);
    if (value > 0) {
      value += 2;
    }
    float hue = value * .02;
    return color(hue % 1.0, 1, 1);
  }

  // Sum finding.
  boolean canSum(int[] neighbors, int target) {
    //return getSums(neighbors).contains(target);
    //SubsetSumAutomata.queries++;
    //neighbors = sort(neighbors);
    //String key = join(nf(neighbors, 0), ","); 
    //if (!sumMap.containsKey(key)) {
      HashSet<Integer> sums = getSums(neighbors);
      return sums.contains(target);
      //sumMap.put(key, sums);
    //} else {
      //SubsetSumAutomata.hits++;
    //}
    //return sumMap.get(key).contains(target);
  }

  HashSet<Integer> getSums(int[] neighbors) {
    HashSet<Integer> sums = new HashSet<Integer>();
    for (int i = 1; i < pow(2, neighbors.length); i++) {
      int sum = 0;
      for (int j = 0; j < neighbors.length; j++) {
        if ((i >> j) % 2 == 1) {
          sum += neighbors[j];
        }
      }
      sums.add(sum);
    }
    return sums;
  }

  int mod(int x, int m)
  {
    return (x % m + m) % m;
  }
  
  float logn (int x, int n) {
    return (log(x) / log(n));
  }
}