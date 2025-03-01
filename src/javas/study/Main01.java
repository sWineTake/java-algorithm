package javas.study;

import java.util.*;

class Main01 {

    public static void main(String[] args) {
        Main01 main01 = new Main01();
        Scanner sc = new Scanner(System.in);
        String src = sc.next();
        int solution = main01.solution(src);

        System.out.println(solution);
    }

    public int solution(String src) {
        int refCount = 0;
        int answer = 0;
        for (int i = 0; i < src.length(); i++) {
            char x = src.charAt(i);

            if (x == '(') {
                refCount++;
            } else {
                if (refCount > 0) {
                    refCount--;

                    if (src.charAt(i - 1) == ')') {
                        answer += refCount;
                    } else {
                        answer += 1;
                    }
                }
            }
        }

        return answer;
    }



}
