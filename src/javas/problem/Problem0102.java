package javas.problem;

import java.util.*;

public class Problem0102 {

    public static void main(String[] args) {
        Map<Character, Integer> map = new HashMap<>();

        Scanner sc = new Scanner(System.in);
        String input = sc.nextLine();

        for (Character c : input.toCharArray()) {

            if (!Character.isAlphabetic(c)) {
                continue;
            }

            int value = map.getOrDefault(c, 0) + 1;
            map.put(c, value);

        }


        char result = 'a';
        int max = 0;
        boolean duplicate = false;

        for (Map.Entry<Character, Integer> entry : map.entrySet()) {
            Character key = entry.getKey();
            Integer value = map.get(key);

            if (value > max) {
                result = key;
                max = value;
            }

        }

        System.out.println(duplicate ? result : -1);

    }

}
