public class SmallestIntegerFinder {
    public static int findSmallestInt(int[] args) {
      int min = args[0];
      for(int num:args){
        if(num<min){
          min = num;
        }
      }
        return min;
    }
}
