package javas.problem;

import java.util.Scanner;

public class Problem2231 {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        Integer value = sc.nextInt();
        String result = "";

        for (int i = value; i <= 0; i--) {

            String toString = value.toString();

            int temp = 0;
            for (char c : toString.toCharArray()) {
                temp += Integer.parseInt(String.valueOf(c));
            }

            if (temp == value) {
                result = toString;
            }

        }

        System.out.println(result);

    }

}
