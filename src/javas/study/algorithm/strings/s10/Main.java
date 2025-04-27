package javas.study.algorithm.strings.s10;
/*
import java.util.*;

public class Main{

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.next();
        char target = sc.next().charAt(0);

        String value = "";
        for (int i = 0; i < input.length(); i++) {
            char temp = input.charAt(i);

            if (temp == target) {
                value += "0";
            } else {

                for (int k = 1; k < input.length(); k++) {
                    int lt = i - k; // 오른쪽으로 갈놈
                    int rt = i + k; // 왼쪽으로 갈놈

                    if (lt >= 0) {
                        if (target == input.charAt(lt)) {
                            value+=k;
                            break;
                        }
                    }
                    if (rt < input.length()) {
                        if (target == input.charAt(rt)) {
                            value+=k;
                            break;
                        }
                    }
                }
            }

            value += " ";
        }

        System.out.println(value);
    }

}

기준	생각 방법
    시간복잡도 판단은 최악을 기준으로 한다	평균 아님, 운 아님
    N이 크면 O(N²) 알고리즘은 아예 고민하지 않는다	즉시 다른 방법 찾아야 한다
    break는 평균 실행시간만 줄일 뿐이다	빅오 시간복잡도는 변하지 않는다
    코테에서는 N이 크면 O(N) or O(N log N)로 풀어야 한다

https://confirmed-text-b1d.notion.site/1e2106911d3580f488e9d5b1764145b0?pvs=4
*/

import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.next();
        char target = sc.next().charAt(0);
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < input.length(); i++) {
            if (input.charAt(i) == target) {
                sb.append(0);
            } else {
                int distance = Integer.MAX_VALUE;

                for (int k = 1; k < input.length(); k++) {
                    int left = i - k;
                    int right = i + k;

                    if (left >= 0 && input.charAt(left) == target) {
                        distance = k;
                        break;
                    }
                    if (right < input.length() && input.charAt(right) == target) {
                        distance = k;
                        break;
                    }
                }
                sb.append(distance);
            }
            sb.append(' ');
        }

        System.out.println(sb.toString());
    }
}
