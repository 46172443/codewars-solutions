# Find Smallest Integer In Array

**Rank:** 8kyu  
**Language:** Java  
**Completed:** 2026-06-15  

---

## Problem
Auto-generated Codewars template.

---

## Solution

```java
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
```
