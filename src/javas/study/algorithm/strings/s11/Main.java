package javas.study.algorithm.strings.s11;
import java.util.*;

public class Main {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        String src = sc.next();

        char temp = src.charAt(0);
        StringBuilder sb = new StringBuilder(temp);
        int cnt = 1;
        for (int i = 1; i < src.length(); i++) {
            char get = src.charAt(i);

            if (temp == get) {
                cnt++;
            } else {
                sb.append(cnt != 1 ? temp + "" + cnt : temp + "");
                temp = get;
                cnt = 1;
            }
        }

        sb.append(cnt != 1 ? temp + "" + cnt : temp + "");
        System.out.println(sb);
    }

}
