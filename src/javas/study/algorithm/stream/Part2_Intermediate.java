package javas.study.algorithm.stream;

import java.util.*;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentMap;
import java.util.stream.*;

/**
 * Part 2: 중급 (16-35)
 * 난이도: ⭐⭐
 * 예상 시간: 90분
 */
public class Part2_Intermediate {

    public static void main(String[] args) {
        Part2_Intermediate test = new Part2_Intermediate();

        System.out.println("16. 나이별 그룹화: " + test.problem16());
        System.out.println("17. 짝수/홀수 분리: " + test.problem17());
        System.out.println("18. 부서별 직원 수: " + test.problem18());
        System.out.println("19. 가격대별 상품 그룹화: " + test.problem19());
        System.out.println("20. 리스트 평탄화: " + test.problem20());
        System.out.println("21. 나이 내림차순: " + test.problem21());
        System.out.println("22. 급여 상위 5명: " + test.problem22());
        System.out.println("23. 처음 3개: " + test.problem23());
        System.out.println("24. 처음 2개 건너뛰기: " + test.problem24());
        System.out.println("25. 단어 길이 Map: " + test.problem25());
        System.out.println("26. 성별 그룹화: " + test.problem26());
        System.out.println("27. 부서별 평균 급여: " + test.problem27());
        System.out.println("28. 상품별 총 판매액: " + test.problem28());
        System.out.println("29. 중복 단어: " + test.problem29());
        System.out.println("30. 가장 긴 문자열: " + test.problem30());
        System.out.println("31. 알파벳순 첫 3개: " + test.problem31());
        System.out.println("32. 단어 출현 횟수: " + test.problem32());
        System.out.println("33. 부서별 최고 급여: " + test.problem33());
        System.out.println("34. 점수 범위별 학생 수: " + test.problem34());
        System.out.println("35. 이름 길이별 그룹화: " + test.problem35());
    }

    // TODO 16: 나이가 같은 사람끼리 그룹화
    // 출력: {25=[Person], 30=[Person, Person], ...}
    public Map<Integer, List<Person>> problem16() {
        List<Person> people = Arrays.asList(
            new Person("김철수", 25),
            new Person("이영희", 30),
            new Person("박민수", 25),
            new Person("최지영", 30),
            new Person("정대호", 35)
        );
        return people.stream().collect(Collectors.groupingBy(Person::getAge));
    }

    // TODO 17: 짝수와 홀수로 분리
    // 출력: {false=[1,3,5,7,9], true=[2,4,6,8,10]}
    public Map<Boolean, List<Integer>> problem17() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5,6,7,8,9,10);
        return numbers.stream().collect(Collectors.groupingBy(n -> n % 2 == 0));
    }

    // TODO 18: 부서별 직원 수 카운트
    // 출력: {"개발팀"=3, "영업팀"=2}
    public Map<String, Long> problem18() {
        List<Employee> employees = Arrays.asList(
            new Employee("김철수", "개발팀", 5000),
            new Employee("이영희", "개발팀", 6000),
            new Employee("박민수", "영업팀", 4500),
            new Employee("최지영", "개발팀", 5500),
            new Employee("정대호", "영업팀", 4800)
        );
        return employees.stream().collect(Collectors.groupingBy(Employee::getDepartment, Collectors.counting()));
    }

    // TODO 19: 가격대별 상품 그룹화 (저가/중가/고가)
    // 10000 미만: "저가", 10000~50000: "중가", 50000 이상: "고가"
    public Map<String, List<Product>> problem19() {
        List<Product> products = Arrays.asList(
            new Product("키보드", 8000),
            new Product("마우스", 5000),
            new Product("스피커", 45000),
            new Product("모니터", 150000),
            new Product("노트북", 1200000)
        );
        return products.stream().collect(Collectors.groupingBy(p -> {
            if (p.getPrice() < 10000) {
                return "저가";
            } else if (p.getPrice() >= 10000 && p.getPrice() < 50000) {
                return "중가";
            }
            return "고가";
        }));
    }

    // TODO 20: 중첩된 리스트를 하나로 평탄화
    // 입력: [[1,2], [3,4], [5,6]]
    // 출력: [1,2,3,4,5,6]
    public List<Integer> problem20() {
        List<List<Integer>> nested = Arrays.asList(
            Arrays.asList(1, 2),
            Arrays.asList(3, 4),
            Arrays.asList(5, 6)
        );

        return nested.stream().flatMap(Collection::stream).toList();
    }

    // TODO 21: 나이를 기준으로 내림차순 정렬
    // 출력: [45세, 40세, 35세, 30세, 25세]
    public List<Integer> problem21() {
        List<Person> people = Arrays.asList(
            new Person("김철수", 25),
            new Person("이영희", 30),
            new Person("박민수", 35),
            new Person("최지영", 40),
            new Person("정대호", 45)
        );

        return people.stream()
            .sorted(Comparator.comparing(Person::getAge).reversed())
            .map(Person::getAge)
            .toList();
    }

    // TODO 22: 급여 상위 5명의 이름
    // 출력: 급여가 높은 순서대로 5명
    public List<String> problem22() {
        List<Employee> employees = Arrays.asList(
            new Employee("김철수", "개발팀", 5000),
            new Employee("이영희", "개발팀", 6000),
            new Employee("박민수", "영업팀", 4500),
            new Employee("최지영", "개발팀", 5500),
            new Employee("정대호", "영업팀", 4800),
            new Employee("홍길동", "인사팀", 7000),
            new Employee("김영수", "인사팀", 4300)
        );

        return employees.stream()
                .sorted(Comparator.comparing(Employee::getSalary).reversed())
                .map(Employee::getName)
                .limit(5)
                .toList();
    }

    // TODO 23: 처음 3개 요소만 가져오기
    // 출력: [1,2,3]
    public List<Integer> problem23() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5,6,7,8,9,10);
        return numbers.stream().limit(3).toList();
    }

    // TODO 24: 처음 2개를 건너뛰고 나머지
    // 출력: [3,4,5,6,7,8,9,10]
    public List<Integer> problem24() {
        List<Integer> numbers = Arrays.asList(1,2,3,4,5,6,7,8,9,10);
        return numbers.stream().skip(2).toList();
    }

    // TODO 25: 단어와 그 길이를 Map으로
    // 출력: {"Apple"=5, "Banana"=6, "Cherry"=6}
    public Map<String, Integer> problem25() {
        List<String> fruits = Arrays.asList("Apple", "Banana", "Cherry");

        return fruits.stream()
                .collect(Collectors.toMap(s -> s, String::length));
    }

    // TODO 26: 성별로 그룹화
    // 출력: {"M"=[Person...], "F"=[Person...]}
    public Map<String, List<Person2>> problem26() {
        List<Person2> people = Arrays.asList(
            new Person2("김철수", "M"),
            new Person2("이영희", "F"),
            new Person2("박민수", "M"),
            new Person2("최지영", "F")
        );

        return people.stream()
                .collect(Collectors.groupingBy(Person2::getGender));
    }

    // TODO 27: 부서별 평균 급여
    // 출력: {"개발팀"=5500.0, "영업팀"=4650.0}
    public Map<String, Double> problem27() {
        List<Employee> employees = Arrays.asList(
            new Employee("김철수", "개발팀", 5000),
            new Employee("이영희", "개발팀", 6000),
            new Employee("박민수", "영업팀", 4500),
            new Employee("최지영", "개발팀", 5500),
            new Employee("정대호", "영업팀", 4800)
        );

        return employees.stream()
            .collect(Collectors.groupingBy(Employee::getDepartment, Collectors.averagingInt(Employee::getSalary)));
    }

    // TODO 28: 각 상품의 총 판매액 (가격 * 수량)
    // 출력: {"노트북"=2400000, "마우스"=50000, ...}
    public Map<String, Integer> problem28() {
        List<Order> orders = Arrays.asList(
            new Order("노트북", 1200000, 2),
            new Order("마우스", 10000, 5),
            new Order("키보드", 50000, 3)
        );
        return orders.stream()
                .collect(Collectors.toMap(Order::getProductName, o -> o.getPrice() * o.getQuantity()));
    }

    // TODO 29: 중복된 단어만 찾기
    // 입력: ["apple", "banana", "apple", "cherry", "banana"]
    // 출력: ["apple", "banana"]
    public List<String> problem29() {
        List<String> words = Arrays.asList("apple", "banana", "apple", "cherry", "banana");
        return words.stream()
                .collect(Collectors.groupingBy(w -> w, Collectors.counting()))
                .entrySet()
                .stream()
                .filter(obj -> obj.getValue() > 1)
                .map(Entry::getKey)
                .toList();
    }

    // TODO 30: 가장 긴 문자열 찾기
    // 출력: "JavaScript"
    public String problem30() {
        List<String> languages = Arrays.asList("Java", "Python", "C", "JavaScript", "Go");
        return languages.stream()
                .max(Comparator.comparingInt(String::length))
                .orElse(null)
                ;
    }

    // TODO 31: 알파벳 순으로 정렬 후 처음 3개
    // 출력: ["Apple", "Banana", "Cherry"]
    public List<String> problem31() {
        List<String> fruits = Arrays.asList("Grape", "Apple", "Cherry", "Banana", "Durian");
        return fruits.stream().sorted().limit(3).toList();
    }

    // TODO 32: 각 단어가 몇 번 나타나는지 카운트
    // 출력: {"apple"=2, "banana"=2, "cherry"=1}
    public Map<String, Long> problem32() {
        List<String> words = Arrays.asList("apple", "banana", "apple", "cherry", "banana");
        return words.stream()
                .collect(Collectors.groupingBy(w -> w, Collectors.counting()));
    }

    // TODO 33: 부서별 최고 급여
    // 출력: {"개발팀"=6000, "영업팀"=4800}
    public Map<String, Integer> problem33() {
        List<Employee> employees = Arrays.asList(
            new Employee("김철수", "개발팀", 5000),
            new Employee("이영희", "개발팀", 6000),
            new Employee("박민수", "영업팀", 4500),
            new Employee("최지영", "개발팀", 5500),
            new Employee("정대호", "영업팀", 4800)
        );
        return employees.stream()
                .collect(Collectors.groupingBy(Employee::getDepartment))
                .entrySet()
                .stream()
                .collect(
                    Collectors.toMap(
                        Map.Entry::getKey,
                        e -> e.getValue().stream().mapToInt(Employee::getSalary).max().orElse(0)
                    )
                )
                ;
    }

    // TODO 34: 점수 범위별 학생 수
    // 0-59: "F", 60-69: "D", 70-79: "C", 80-89: "B", 90-100: "A"
    // 출력: {"A"=2, "B"=2, "C"=1}
    public Map<String, Long> problem34() {
        List<Student> students = Arrays.asList(
            new Student("김철수", 85),
            new Student("이영희", 92),
            new Student("박민수", 78),
            new Student("최지영", 95),
            new Student("정대호", 88)
        );
        return students.stream()
                .collect(Collectors.groupingBy(s -> {
                    if (s.getScore() < 60) return "F";
                    else if (s.getScore() >= 60 && s.getScore() <= 69) return "D";
                    else if (s.getScore() >= 70 && s.getScore() <= 79) return "C";
                    else if (s.getScore() >= 80 && s.getScore() <= 89) return "B";
                    return "A";
                }, Collectors.counting()));
    }

    // TODO 35: 이름 길이별로 그룹화
    // 출력: {3=[Person...], 4=[Person...]}
    public Map<Integer, List<Person>> problem35() {
        List<Person> people = Arrays.asList(
            new Person("김철수", 25),
            new Person("이영희", 30),
            new Person("박", 25),
            new Person("최지", 30),
            new Person("정대", 35)
        );

        return people.stream()
                .collect(Collectors.groupingBy(p -> p.getName().length()));
    }
}

class Person {
    String name;
    int age;
    Person(String name, int age) { this.name = name; this.age = age; }
    String getName() { return name; }
    int getAge() { return age; }
    @Override
    public String toString() { return name + "(" + age + "세)"; }
}

class Person2 {
    String name;
    String gender;
    Person2(String name, String gender) { this.name = name; this.gender = gender; }
    String getName() { return name; }
    String getGender() { return gender; }
    @Override
    public String toString() { return name + "(" + gender + ")"; }
}

class Employee {
    String name;
    String department;
    int salary;
    Employee(String name, String department, int salary) {
        this.name = name; this.department = department; this.salary = salary;
    }
    String getName() { return name; }
    String getDepartment() { return department; }
    int getSalary() { return salary; }
}

class Product {
    String name;
    int price;
    Product(String name, int price) { this.name = name; this.price = price; }
    String getName() { return name; }
    int getPrice() { return price; }
    @Override
    public String toString() { return name + "(" + price + "원)"; }
}

class Order {
    String productName;
    int price;
    int quantity;
    Order(String productName, int price, int quantity) {
        this.productName = productName; this.price = price; this.quantity = quantity;
    }
    String getProductName() { return productName; }
    int getPrice() { return price; }
    int getQuantity() { return quantity; }
}

class Student {
    String name;
    int score;
    Student(String name, int score) { this.name = name; this.score = score; }
    String getName() { return name; }
    int getScore() { return score; }
}
