-- ========================================
-- 중급 (1-5)
-- ========================================

-- TODO 1: Self JOIN - 직원과 매니저
SELECT 
    e.name as employee_name,
    m.name as manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.manager_id IS NOT NULL;


-- TODO 2: 고객별 총 구매 금액
SELECT 
    c.name,
    SUM(p.price * oi.quantity) as total_amount,
    COUNT(oi.id) as order_count
FROM customers c
INNER JOIN order_items oi ON c.id = oi.customer_id
INNER JOIN products p ON oi.product_id = p.id
GROUP BY c.id, c.name
ORDER BY total_amount DESC;


-- TODO 3: 카테고리 평균보다 높은 가격의 상품
SELECT 
    p.category,
    p.product_name,
    p.price,
    ROUND(AVG(p.price) OVER (PARTITION BY p.category)) as category_avg_price
FROM products p
WHERE p.price > (
    SELECT AVG(price) 
    FROM products 
    WHERE category = p.category
)
ORDER BY p.category, p.price DESC;


-- TODO 4: 부서별 최고 연봉자
SELECT 
    d.dept_name,
    e.name,
    e.salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE (e.department_id, e.salary) IN (
    SELECT department_id, MAX(salary)
    FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id
)
ORDER BY d.dept_name;


-- TODO 5: 월별 매출 피벗
SELECT 
    SUM(CASE WHEN MONTH(sale_date) = 1 THEN amount ELSE 0 END) as jan_sales,
    SUM(CASE WHEN MONTH(sale_date) = 2 THEN amount ELSE 0 END) as feb_sales,
    SUM(CASE WHEN MONTH(sale_date) = 3 THEN amount ELSE 0 END) as mar_sales
FROM sales
WHERE YEAR(sale_date) = 2024;


-- ========================================
-- 고급 (6-12)
-- ========================================

-- TODO 6: 일별 누적 판매 수량
SELECT 
    product_id,
    sale_date,
    quantity,
    SUM(quantity) OVER (PARTITION BY product_id ORDER BY sale_date) as cumulative_quantity
FROM sales
ORDER BY product_id, sale_date;


-- TODO 7: 전월 대비 매출 증감률
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') as year_month,
    SUM(amount) as current_month_sales,
    LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) as prev_month_sales,
    ROUND(
        (SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))) 
        / LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) * 100, 
        2
    ) as growth_rate
FROM sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY year_month;


-- TODO 8: 고객 등급별 비율
SELECT 
    grade,
    COUNT(*) as customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 2) as percentage
FROM customers
GROUP BY grade
ORDER BY customer_count DESC;


-- TODO 9: 매니저별 부하 직원 수
SELECT 
    m.name as manager_name,
    COUNT(e.id) as subordinate_count
FROM employees e
INNER JOIN employees m ON e.manager_id = m.id
GROUP BY m.id, m.name
ORDER BY subordinate_count DESC;


-- TODO 10: 3개월 이동 평균
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') as year_month,
    SUM(amount) as monthly_sales,
    ROUND(AVG(SUM(amount)) OVER (
        ORDER BY DATE_FORMAT(sale_date, '%Y-%m')
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) as moving_avg_3month
FROM sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY year_month;


-- TODO 11: 상품별 매출 순위
SELECT 
    RANK() OVER (ORDER BY SUM(amount) DESC) as ranking,
    p.product_name,
    SUM(s.amount) as total_sales
FROM sales s
INNER JOIN products p ON s.product_id = p.id
GROUP BY p.id, p.product_name
ORDER BY ranking;


-- TODO 12: 부서별 급여 상위 30%
SELECT 
    d.dept_name,
    e.name,
    e.salary,
    NTILE(10) OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as percentile
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE e.department_id IS NOT NULL
HAVING percentile <= 3
ORDER BY d.dept_name, e.salary DESC;


-- ========================================
-- 최상급 (13-20)
-- ========================================

-- TODO 13: 재귀 쿼리 - 조직도
WITH RECURSIVE org_chart AS (
    -- 기본: CEO
    SELECT 
        id,
        name,
        manager_id,
        1 as level,
        name as path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- 재귀: 하위 직원들
    SELECT 
        e.id,
        e.name,
        e.manager_id,
        oc.level + 1,
        CONCAT(oc.path, ' > ', e.name)
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.id
)
SELECT 
    name,
    level,
    path
FROM org_chart
ORDER BY level, name;


-- TODO 14: 연속 3일 이상 매출 발생 상품
SELECT 
    product_id,
    p.product_name,
    COUNT(*) as consecutive_days
FROM (
    SELECT 
        product_id,
        sale_date,
        DATEDIFF(sale_date, 
            LAG(sale_date) OVER (PARTITION BY product_id ORDER BY sale_date)
        ) as day_diff
    FROM sales
) sub
INNER JOIN products p ON sub.product_id = p.id
WHERE day_diff = 1 OR day_diff IS NULL
GROUP BY product_id, p.product_name
HAVING COUNT(*) >= 3;


-- TODO 15: 월별 Top 3 상품
SELECT 
    year_month,
    ranking,
    product_name,
    monthly_sales
FROM (
    SELECT 
        DATE_FORMAT(s.sale_date, '%Y-%m') as year_month,
        p.product_name,
        SUM(s.amount) as monthly_sales,
        RANK() OVER (
            PARTITION BY DATE_FORMAT(s.sale_date, '%Y-%m')
            ORDER BY SUM(s.amount) DESC
        ) as ranking
    FROM sales s
    INNER JOIN products p ON s.product_id = p.id
    GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m'), p.id, p.product_name
) ranked
WHERE ranking <= 3
ORDER BY year_month, ranking;


-- TODO 16: 고객의 첫/마지막 구매일과 경과일수
SELECT 
    c.name,
    MIN(oi.order_date) as first_order_date,
    MAX(oi.order_date) as last_order_date,
    DATEDIFF(MAX(oi.order_date), MIN(oi.order_date)) as days_diff,
    SUM(p.price * oi.quantity) as total_purchase_amount
FROM customers c
INNER JOIN order_items oi ON c.id = oi.customer_id
INNER JOIN products p ON oi.product_id = p.id
GROUP BY c.id, c.name
ORDER BY total_purchase_amount DESC;


-- TODO 17: 부서별 평균 급여 초과자 수와 비율
SELECT 
    d.dept_name,
    ROUND(AVG(e.salary)) as avg_salary,
    SUM(CASE WHEN e.salary > dept_avg.avg_sal THEN 1 ELSE 0 END) as exceed_count,
    COUNT(*) as total_count,
    ROUND(
        SUM(CASE WHEN e.salary > dept_avg.avg_sal THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) as exceed_ratio
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN (
    SELECT department_id, AVG(salary) as avg_sal
    FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id
) dept_avg ON e.department_id = dept_avg.department_id
WHERE e.department_id IS NOT NULL
GROUP BY d.dept_name, dept_avg.avg_sal;


-- TODO 18: 월별 신규/누적 고객 수
SELECT 
    DATE_FORMAT(join_date, '%Y-%m') as year_month,
    COUNT(*) as new_customers,
    SUM(COUNT(*)) OVER (ORDER BY DATE_FORMAT(join_date, '%Y-%m')) as cumulative_customers
FROM customers
GROUP BY DATE_FORMAT(join_date, '%Y-%m')
ORDER BY year_month;


-- TODO 19: 카테고리별 매출 비중
SELECT 
    p.category,
    SUM(s.amount) as category_sales,
    ROUND(
        SUM(s.amount) * 100.0 / (SELECT SUM(amount) FROM sales),
        2
    ) as sales_ratio
FROM sales s
INNER JOIN products p ON s.product_id = p.id
GROUP BY p.category
ORDER BY category_sales DESC;


-- TODO 20: 입사 순위 (전사 & 부서별)
SELECT 
    e.name,
    d.dept_name,
    e.hire_date,
    ROW_NUMBER() OVER (ORDER BY e.hire_date) as company_rank,
    ROW_NUMBER() OVER (PARTITION BY e.department_id ORDER BY e.hire_date) as dept_rank
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
ORDER BY e.hire_date;
