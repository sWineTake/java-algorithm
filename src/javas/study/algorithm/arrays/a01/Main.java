package javas.study.algorithm.arrays.a01;

import java.util.*;

public class Main {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        int value = sc.nextInt();
        int[] arr = new int[value];

        for (int i = 0; i < arr.length; i++) {
            arr[i] = sc.nextInt();
        }


        System.out.print(arr[0] + " ");
        for (int i = 0; i < arr.length - 1; i++) {

            int temp1 = arr[i];
            int temp2 = arr[i + 1];
            if (temp1 < temp2) {
                System.out.print(temp2);
                if (i < arr.length - 2) {
                    System.out.print(" ");
                }
            }

        }

    }


}
