package javas.study.algorithm.strings.s12;
import java.util.*;

public class Main {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        int count = sc.nextInt();
        String src = sc.next();

        src = src.replace('#', '1');
        src = src.replace('*', '0');

        String value = "";
        for (int i = 0; i<count; i++) {
            String subStr = src.substring(0, 7);
            int digit = Integer.parseInt(subStr, 2);
            value += (char) digit;
            src = src.substring(7);
        }

        System.out.println(value);

    }

}
