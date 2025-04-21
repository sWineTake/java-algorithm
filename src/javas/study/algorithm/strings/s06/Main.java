package javas.study.algorithm.strings.s06;
/*
설명
    소문자로 된 한개의 문자열이 입력되면 중복된 문자를 제거하고 출력하는 프로그램을 작성하세요.
    중복이 제거된 문자열의 각 문자는 원래 문자열의 순서를 유지합니다.

입력
    첫 줄에 문자열이 입력됩니다. 문자열의 길이는 100을 넘지 않는다.

출력
    첫 줄에 중복문자가 제거된 문자열을 출력합니다.

    Hash 계열 (HashSet, HashMap)
        해싱을 기반으로 동작하므로, 데이터가 저장되는 순서를 보장하지 않습니다.
        수정 시에도 순서는 달라질 수 있습니다.
        빠른 데이터 검색과 삽입을 중점으로 설계되었습니다.
    LinkedHash 계열 (LinkedHashSet, LinkedHashMap)
        데이터의 입력 순서를 유지합니다.
        내부적으로 **이중 연결 리스트(Doubly-Linked List)**를 사용하여 순서를 추적합니다.
        순서가 중요한 경우 LinkedHashSet 또는 LinkedHashMap을 사용하세요.
*/

import java.util.LinkedHashSet;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String str = sc.next();
        LinkedHashSet<Character> set = new LinkedHashSet<>();

        for (char temp : str.toCharArray()) {
            set.add(temp);
        }

        String value = "";
        for (char temp : set) {
            value += temp;
        }

        System.out.println(value);
    }

}
