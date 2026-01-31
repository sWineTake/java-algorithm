-- ========================================
-- Part 1: 기초 (1-7)
-- ========================================

-- TODO 1: 모든 직원의 이름과 급여를 조회
-- 예상 결과: 15행
--
select e.name,
       e.salary
from employees e;


-- TODO 2: 급여가 5000 이상인 직원의 이름과 급여
-- 예상 결과: 9행
--
select e.name,
       e.salary
from employees e
where e.salary >= 5000
;

-- TODO 3: 모든 직원을 급여 내림차순으로 정렬 (이름, 급여)
-- 예상 결과: 최수진(7000), 윤서아(6500), ...
--
select e.name,
       e.salary
from employees e
order by e.salary desc
;

-- TODO 4: 개발팀(department_id = 1) 직원 수는?
-- 예상 결과: 5
--
SELECT select count(1)
from employees e
where e.department_id = 1

-- TODO 5: 전체 직원의 평균 급여는? (소수점 반올림)
-- 예상 결과: 5180
--
select ROUND(AVG(salary), 2) AS AVG_SALARY
from employees e


-- TODO 6: 급여가 높은 상위 5명의 이름과 급여
-- 예상 결과: 최수진, 윤서아, 이영희, 최지영, 임수빈
--
select e.name,
       e.salary
from employees e
order by e.salary desc
limit 5;


-- TODO 7: 고객이 속한 도시 목록 (중복 제거)
-- 예상 결과: 서울, 부산, 대전, 광주
--
select distinct city
from customers;

-- ========================================
-- Part 2: 중급 (8-14)
-- ========================================

-- TODO 8: 직원 이름과 소속 부서명을 함께 조회
-- 예상 결과: 김철수 - 개발팀, 이영희 - 개발팀, ...
-- 힌트: INNER JOIN
--
select concat(e.name, ' - ', d.dept_name) as name_dept
from employees e
inner join departments d on e.department_id = d.id;


-- TODO 9: 부서별 직원 수를 조회 (부서명, 직원수)
-- 예상 결과: 개발팀(5), 영업팀(4), 인사팀(3), 마케팅팀(3)
-- 힌트: GROUP BY
--
select concat(d.dept_name, '(',
      (
          select count(1) from employees e where e.department_id = d.id
      ), ')') AS dept_name_count
from departments d
;

-- TODO 10: 부서별 평균 급여 (부서명, 평균급여)
-- 예상 결과: 개발팀(6000), 영업팀(4725), ...
-- 힌트: GROUP BY + AVG()
--
select d.dept_name,
       round((
                 select avg(e.salary)
                 from employees e
                 where e.department_id = d.id
             ),2) AS avg_salary
from departments d


-- TODO 11: 고객 이름과 주문한 상품명을 조회
-- 예상 결과: 고객A - 노트북, 고객A - 마우스, ...
-- 힌트: orders, customers, products 3개 테이블 JOIN
--
select concat(c.name, ' - ', p.product_name) AS name
from customers c
inner join orders o on c.id = o.customer_id
inner join products p on o.product_id = p.id
;

-- TODO 12: 카테고리별 상품 수와 평균 가격
-- 예상 결과: 전자제품(7개, 평균), 가구(3개, 평균)
--
select CONCAT(p.category , '(', count(1), '개,' , round(avg(p.price), 2), ')') AS avg_price
from products p
group by p.category
;


-- TODO 13: 직원이 3명 이상인 부서만 조회 (부서명, 직원수)
-- 예상 결과: 개발팀(5), 영업팀(4), 인사팀(3), 마케팅팀(3)
-- 힌트: HAVING
--
SELECT (
           SELECT d.dept_name
           FROM departments d WHERE d.id = e.department_id
       ) AS dept_name,
       COUNT(1)
FROM employees e
GROUP BY e.department_id
HAVING COUNT(1) >= 3


-- TODO 14: 각 주문의 총 금액 계산 (주문ID, 상품명, 수량, 단가, 총액)
-- 총액 = 상품가격 * 수량
-- 예상 결과: 1번 주문 - 노트북 * 1 = 1200000
--
SELECT o.id,
    p.product_name,
       o.quantity,
       p.price,
       o.quantity * p.price
FROM orders o
    inner join products p on o.product_id = p.id
    inner join customers c on o.customer_id = c.id
;
-- ========================================
-- Part 3: 고급 (15-20)
-- ========================================

-- TODO 15: 평균 급여보다 높은 급여를 받는 직원 (이름, 급여)
-- 예상 결과: 9명
-- 힌트: 서브쿼리
--
SELECT e.name,
       e.salary
FROM employees e
WHERE e.salary > (select avg(sub_e.salary) from employees sub_e)
;

-- TODO 16: 가장 많이 판매된 상품 TOP 3 (상품명, 총판매수량)
-- 힌트: SUM(quantity), ORDER BY, LIMIT
--
select  count(1),
        (
            select p.product_name
            from products p
            where p.id = o.product_id
        ) AS product_name,
        sum(o.quantity)

from orders o

group by o.product_id
order by 1 desc
    limit 3
;


-- TODO 17: 부서별 급여 순위 (부서명, 이름, 급여, 순위)
-- 힌트: RANK() OVER (PARTITION BY ... ORDER BY ...)
-- 예상 결과: 개발팀 내에서 1위 최수진(7000), 2위 윤서아(6500), ...
--
SELECT
    d.dept_name,
    e.name,
    e.salary,
    RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary) AS '순위'
FROM departments d
INNER JOIN employees e ON e.department_id = d.id
;

-- TODO 18: 월별 총 매출액 (년월, 매출액)
-- 예상 결과: 2024-01, 2024-02, 2024-03, ...
-- 힌트: DATE_FORMAT(), SUM(price * quantity)
--

SELECT CONCAT(B.Y, '-', B.M) AS data,
       B.amount
FROM (
         SELECT YEAR(A.order_date) AS Y,
             DATE_FORMAT(A.order_date, '%m') AS M,
             SUM(total_amount) AS amount
         FROM (
             SELECT o.order_date,
             p.price * o.quantity AS total_amount
             FROM orders o
             inner join products p on o.product_id = p.id
             ) AS A
         GROUP BY YEAR(A.order_date),DATE_FORMAT(A.order_date, '%m')
     ) AS B
;


-- TODO 19: 급여 등급 분류 (이름, 급여, 등급)
-- 7000 이상: 'S급'
-- 6000 이상: 'A급'
-- 5000 이상: 'B급'
-- 그 외: 'C급'
-- 힌트: CASE WHEN
--
SELECT e.name,
       e.salary,
       CASE
           WHEN e.salary >= 7000 THEN 'S급'
           WHEN e.salary >= 6000 THEN 'A급'
           WHEN e.salary >= 5000 THEN 'B급'
           ELSE 'C급'
           END AS cas
FROM employees e;



-- TODO 20: 한 번도 주문하지 않은 고객 조회
-- 예상 결과: 없음 (모든 고객이 주문함)
-- 힌트: LEFT JOIN + IS NULL 또는 NOT IN
--
select c.id, o.id
from customers c
         left join orders o on c.id = o.customer_id
where o.id is null
;
