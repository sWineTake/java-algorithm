package javas.study.algorithm.strings.s02;
import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.next();
        String value = "";
        for (char temp : input.toCharArray()) {
            if (Character.isUpperCase(temp)) {
                value += Character.toLowerCase(temp);
            } else {
                value += Character.toUpperCase(temp);
            }
        }

        System.out.println(value);
    }

}
