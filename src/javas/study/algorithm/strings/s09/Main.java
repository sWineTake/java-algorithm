package javas.study.algorithm.strings.s09;

/*
기능	메서드
영어 알파벳인지	Character.isAlphabetic(char c)
숫자인지	Character.isDigit(char c)
대문자인지	Character.isUpperCase(char c)
소문자인지	Character.isLowerCase(char c)

import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.next();

        String temp = input.replaceAll("[^0-9]", "");

        Integer result = Integer.parseInt(temp);
        System.out.println(result);

    }

}
*/

import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.next();

        String value = "";
        for (char c : input.toCharArray()) {
            if (Character.isDigit(c)) {
                value += c;
            }
        }

        Integer result = Integer.parseInt(value);
        System.out.println(result);

    }

}
