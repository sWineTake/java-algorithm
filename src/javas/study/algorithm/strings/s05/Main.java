package javas.study.algorithm.strings.s05;

/*설명
    영어 알파벳과 특수문자로 구성된 문자열이 주어지면 영어 알파벳만 뒤집고,
    특수문자는 자기 자리에 그대로 있는 문자열을 만들어 출력하는 프로그램을 작성하세요.

입력
    첫 줄에 길이가 100을 넘지 않는 문자열이 주어집니다.

출력
    첫 줄에 알파벳만 뒤집힌 문자열을 출력합니다.*/

import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String str = sc.next();
        char[] r = str.toCharArray();

        int rt = 0;
        int lt = r.length - 1;

        while(rt < lt) {

            if (!Character.isAlphabetic(r[rt])) {
                rt++;
            } else if (!Character.isAlphabetic(r[lt])) {
                lt--;
            } else {
                char temp = r[rt];
                r[rt] = r[lt];
                r[lt] = temp;
                rt++;
                lt--;
            }

        }

        System.out.println(String.valueOf(r));

    }

}
