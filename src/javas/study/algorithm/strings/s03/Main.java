package javas.study.algorithm.strings.s03;

import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.nextLine();
        String[] arr = input.split("\\s+");

        String answer = "";

        for (String temp : arr) {
            if (answer.length() < temp.length()) {
                answer = temp;
            }
        }

        System.out.println(answer);

    }


}
