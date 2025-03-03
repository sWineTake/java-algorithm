package javas.study;

import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String a = scanner.next();
        String list = scanner.next();

        Main m = new Main();
        m.solution(a, list);
    }

    public void solution(String a, String list) {
        Queue<Character> queue = new LinkedList<>();

        for (char x : a.toCharArray()) {
            queue.offer(x);
        }

        for (char x : list.toCharArray()) {
            if (!queue.isEmpty() && queue.peek() == x) {
                queue.poll();
            }
            if (queue.isEmpty()) {
                System.out.println("YES");
                return;
            }

        }

        System.out.println("NO");
    }

}
