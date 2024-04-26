class Solution {
  int arrangeCoins(int n) {
    List<int> j = [];
    int result = 0;
    int qator = 1;
    int i = 0;
    while (i < n) {
      i++;
      j.add(i);
      if (qator == j.length) {
        result = j.length;
        j.clear();
        qator++;
      }
    }
    return result;
  }
}
