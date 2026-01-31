package javas.study.algorithm.stream.problem1;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Part 1: 기초 (1-15)
 * 난이도: ⭐
 * 예상 시간: 45분
 */
public class Part1_Basic {

    public static void main(String[] args) {
        Part1_Basic test = new Part1_Basic();

        System.out.println("1. 짝수 필터링: " + test.problem1());
        System.out.println("2. 3의 배수 개수: " + test.problem2());
        System.out.println("3. 길이 5 이상 문자열: " + test.problem3());
        System.out.println("4. 숫자 제곱: " + test.problem4());
        System.out.println("5. 문자열 앞 3글자: " + test.problem5());
        System.out.println("6. 최댓값: " + test.problem6());
        System.out.println("7. 최솟값: " + test.problem7());
        System.out.println("8. 합계: " + test.problem8());
        System.out.println("9. 중복 제거: " + test.problem9());
        System.out.println("10. 첫 번째 요소: " + test.problem10());
        System.out.println("11. 문자열 결합: " + test.problem11());
        System.out.println("12. 10보다 큰 수 존재: " + test.problem12());
        System.out.println("13. 모두 양수: " + test.problem13());
        System.out.println("14. 10~20 범위 개수: " + test.problem14());
        //System.out.println("15. 사람 이름 리스트: " + test.problem15());
    }

    // TODO 1: 짝수만 필터링
    // 입력: [1,2,3,4,5,6,7,8,9,10]
    // 출력: [2,4,6,8,10]
    public List<Integer> problem1() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5,6,7,8,9,10);

        return numbers.stream()
                .filter(n -> n % 2 == 0)
                .toList();

    }

    // TODO 2: 3의 배수 개수 세기
    // 입력: [1,2,3,4,5,6,7,8,9,10,11,12]
    // 출력: 4
    public long problem2() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5,6,7,8,9,10,11,12);
        return numbers.stream()
                .filter(n -> n%3 == 0)
                .count();
    }

    // TODO 3: 길이가 5 이상인 문자열만 필터링
    // 입력: ["Java", "Python", "C", "JavaScript", "Go"]
    // 출력: ["Python", "JavaScript"]
    public List<String> problem3() {
        List<String> languages = Arrays.asList("Java", "Python", "C", "JavaScript", "Go");
        return languages.stream()
                .filter(n -> n.length() >= 5)
                .toList();
    }

    // TODO 4: 각 숫자를 제곱
    // 입력: [1,2,3,4,5]
    // 출력: [1,4,9,16,25]
    public List<Integer> problem4() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5);

        return numbers.stream()
                .map(n -> n * n)
                .toList();
    }

    // TODO 5: 각 문자열의 앞 3글자만 추출
    // 입력: ["Hello", "World", "Java"]
    // 출력: ["Hel", "Wor", "Jav"]
    public List<String> problem5() {
        List<String> words = Arrays.asList("Hello", "World", "Java");
        return words.stream()
            .map(n -> n.substring(0, 3))
            .toList();
    }

    // TODO 6: 최댓값 찾기
    // 입력: [5,2,8,1,9,3]
    // 출력: 9
    public int problem6() {
        List<Integer> numbers = Arrays.asList(5,2,8,1,9,3);

        return numbers.stream().max(Integer::compareTo).get();
    }

    // TODO 7: 최솟값 찾기
    // 입력: [5,2,8,1,9,3]
    // 출력: 1
    public int problem7() {
        List<Integer> numbers = Arrays.asList(5,2,8,1,9,3);
        return numbers.stream().min(Integer::compare).get();
    }

    // TODO 8: 모든 숫자의 합계
    // 입력: [1,2,3,4,5]
    // 출력: 15
    public int problem8() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5);

        return numbers.stream().reduce(0, Integer::sum);
    }

    // TODO 9: 중복 제거
    // 입력: [1,2,2,3,3,3,4,4,4,4]
    // 출력: [1,2,3,4]
    public List<Integer> problem9() {
        List<Integer> numbers = Arrays.asList(1,2,2,3,3,3,4,4,4,4);
        return numbers.stream().distinct().toList();
    }

    // TODO 10: 첫 번째 요소 찾기
    // 입력: [5,2,8,1,9]
    // 출력: 5
    public int problem10() {
        List<Integer> numbers = Arrays.asList(5,2,8,1,9);
        return numbers.stream().findFirst().get();
    }

    // TODO 11: 문자열 리스트를 쉼표로 결합
    // 입력: ["Apple", "Banana", "Cherry"]
    // 출력: "Apple,Banana,Cherry"
    public String problem11() {
        List<String> fruits = Arrays.asList("Apple", "Banana", "Cherry");
        return fruits.stream().collect(Collectors.joining(","));
    }

    // TODO 12: 10보다 큰 숫자가 하나라도 있는지 확인
    // 입력: [1,5,8,12,3]
    // 출력: true
    public boolean problem12() {
        List<Integer> numbers = Arrays.asList(1,5,8,12,3);

        return numbers.stream().anyMatch(n -> n > 10);
    }

    // TODO 13: 모든 숫자가 양수인지 확인
    // 입력: [1,2,3,4,5]
    // 출력: true
    public boolean problem13() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5);
        return numbers.stream().allMatch(n -> n > 0);
    }

    // TODO 14: 10 이상 20 미만 범위의 숫자 개수
    // 입력: [5,12,8,19,22,15,3]
    // 출력: 3
    public long problem14() {
        List<Integer> numbers = Arrays.asList(5,12,8,19,22,15,3);
        return numbers.stream()
                .filter(n -> n >= 10 && n < 20)
                .count();
    }

    // TODO 15: Person 리스트에서 이름만 추출
    // 출력: ["김철수", "이영희", "박민수"]
    /*public List<String> problem15() {
        List<Person> people = Arrays.asList(
            new Person("김철수", 25),
            new Person("이영희", 30),
            new Person("박민수", 35)
        );
        return people.stream().map(Person::getName).toList();
    }

    public class Person {
        String name;
        int age;
        Person(String name, int age) { this.name = name; this.age = age; }
        String getName() { return name; }
        int getAge() { return age; }
    }*/
}


