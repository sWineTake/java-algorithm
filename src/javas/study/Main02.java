package javas.study;

import java.util.*;

public class Main02 {

    public static void main(String[] args) {
        Main02 m = new Main02();
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int k = sc.nextInt();

        System.out.println(m.solution(n, k));
    }

    public int solution(int n, int k) {
        Queue<Integer> queue = new LinkedList<>();

        for (int i = 1; i <= n; i++) {
            queue.offer(i);
        }

        while (queue.size() > 1) {
            for (int i = 1; i <= k; i++) {
                if (i==k) {
                    queue.poll();
                } else {
                    queue.offer(queue.poll());
                }
            }
        }

        return queue.poll();
    }
}
