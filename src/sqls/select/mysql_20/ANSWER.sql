-- ========================================
-- Part 1: 기초 (1-7)
-- ========================================

-- TODO 1: 모든 직원의 이름과 급여를 조회
SELECT name, salary FROM employees;


-- TODO 2: 급여가 5000 이상인 직원의 이름과 급여
SELECT name, salary 
FROM employees 
WHERE salary >= 5000;


-- TODO 3: 모든 직원을 급여 내림차순으로 정렬
SELECT name, salary 
FROM employees 
ORDER BY salary DESC;


-- TODO 4: 개발팀 직원 수
SELECT COUNT(*) as count
FROM employees 
WHERE department_id = 1;


-- TODO 5: 전체 직원의 평균 급여
SELECT ROUND(AVG(salary)) as avg_salary
FROM employees;


-- TODO 6: 급여 상위 5명
SELECT name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;


-- TODO 7: 고객 도시 목록 (중복 제거)
SELECT DISTINCT city 
FROM customers 
ORDER BY city;


-- ========================================
-- Part 2: 중급 (8-14)
-- ========================================

-- TODO 8: 직원과 부서명 조회
SELECT e.name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;


-- TODO 9: 부서별 직원 수
SELECT d.dept_name, COUNT(e.id) as employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.id, d.dept_name;


-- TODO 10: 부서별 평균 급여
SELECT d.dept_name, ROUND(AVG(e.salary)) as avg_salary
FROM departments d
INNER JOIN employees e ON d.id = e.department_id
GROUP BY d.id, d.dept_name;


-- TODO 11: 고객과 주문 상품 조회
SELECT c.name as customer_name, p.product_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON o.product_id = p.id;


-- TODO 12: 카테고리별 상품 수와 평균 가격
SELECT 
    category, 
    COUNT(*) as product_count,
    ROUND(AVG(price)) as avg_price
FROM products
GROUP BY category;


-- TODO 13: 직원이 3명 이상인 부서
SELECT d.dept_name, COUNT(e.id) as employee_count
FROM departments d
INNER JOIN employees e ON d.id = e.department_id
GROUP BY d.id, d.dept_name
HAVING COUNT(e.id) >= 3;


-- TODO 14: 각 주문의 총 금액
SELECT 
    o.id as order_id,
    p.product_name,
    o.quantity,
    p.price,
    (p.price * o.quantity) as total_amount
FROM orders o
INNER JOIN products p ON o.product_id = p.id;


-- ========================================
-- Part 3: 고급 (15-20)
-- ========================================

-- TODO 15: 평균 급여보다 높은 직원
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;


-- TODO 16: 가장 많이 판매된 상품 TOP 3
SELECT 
    p.product_name,
    SUM(o.quantity) as total_quantity
FROM orders o
INNER JOIN products p ON o.product_id = p.id
GROUP BY p.id, p.product_name
ORDER BY total_quantity DESC
LIMIT 3;


-- TODO 17: 부서별 급여 순위
SELECT 
    d.dept_name,
    e.name,
    e.salary,
    RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) as salary_rank
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;


-- TODO 18: 월별 총 매출액
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') as year_month,
    SUM(p.price * o.quantity) as total_sales
FROM orders o
INNER JOIN products p ON o.product_id = p.id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY year_month;


-- TODO 19: 급여 등급 분류
SELECT 
    name,
    salary,
    CASE 
        WHEN salary >= 7000 THEN 'S급'
        WHEN salary >= 6000 THEN 'A급'
        WHEN salary >= 5000 THEN 'B급'
        ELSE 'C급'
    END as grade
FROM employees
ORDER BY salary DESC;


-- TODO 20: 한 번도 주문하지 않은 고객
-- 방법 1: LEFT JOIN
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

-- 방법 2: NOT IN
SELECT name
FROM customers
WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- 방법 3: NOT EXISTS
SELECT name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.id
);
