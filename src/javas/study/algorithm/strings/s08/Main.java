package javas.study.algorithm.strings.s08;
import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String inputSrc = sc.nextLine().toUpperCase().replaceAll("[^A-Z]", "");

        String temp = new StringBuilder(inputSrc).reverse().toString();

        if (temp.equals(inputSrc)) System.out.println("YES");
        else System.out.println("NO");
    }

}
