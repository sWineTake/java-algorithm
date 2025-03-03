package javas.study;

import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

public class Main03 {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String a = scanner.next();
        String list = scanner.next();

        Main03 m = new Main03();
        m.solution(a, list);
    }

    public void solution(String a, String list) {
        Queue<Character> queue = new LinkedList<>();

        for (char x : a.toCharArray()) {
            queue.offer(x);
        }

        for (char x : list.toCharArray()) {

            Character peek = queue.peek();
            if (peek == null) {
                break;
            }
            if (peek == x) {
                queue.poll();
            }

        }

        String result = queue.isEmpty() ? "YES" : "NO";
        System.out.println(result);
    }
}
