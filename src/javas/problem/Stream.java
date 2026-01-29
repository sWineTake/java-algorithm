package javas.problem;

import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Stream {


    public static void main(String[] args) {

        List<Product> products = Arrays.asList(
                new Product("Laptop", "Electronics", 1200),
                new Product("Mouse", "Electronics", 25),
                new Product("Desk", "Furniture", 300),
                new Product("Chair", "Furniture", 150),
                new Product("Monitor", "Electronics", 400)
        );

        Map<String, Double> collect = products.stream()
                .collect(
                        Collectors.groupingBy(
                                Product::getCategory,
                                Collectors.averagingInt(Product::getPrice)
                        )
                );

        System.out.println(collect);

    }




}
