-- ========================================
-- 중급 (1-5) ⭐⭐
-- ========================================

-- TODO 1: 각 직원과 그의 매니저 이름을 함께 조회
-- 출력: 직원명, 매니저명
-- 힌트: Self JOIN
-- 예상: 인사사원A - 인사팀장, 백엔드A - 백엔드팀장, ...
select e.name,
       ee.name
from employees e
left join employees ee on ee.id = e.manager_id
;

-- TODO 2: 고객별 총 구매 금액과 구매 횟수 (금액 내림차순)
-- 출력: 고객명, 총구매금액, 구매횟수
-- 단, 구매 금액 = 상품가격 * 수량
select c.id,
       c.name,
       sum(oi.quantity * p.price) AS total_amount,
       count(1)
from customers c
         inner join order_items oi on c.id = oi.customer_id
         inner join products p on oi.product_id = p.id
group by c.id, c.name
order by total_amount desc
;


-- TODO 3: 카테고리별 상품 중 가격이 카테고리 평균보다 높은 상품
-- 출력: 카테고리, 상품명, 가격, 카테고리평균가격
-- 힌트: 서브쿼리 또는 윈도우 함수
with avg_category AS (
    select sub_p.category, avg(sub_p.price) as avg_price
    from products sub_p
    group by sub_p.category
)
select p.category,
       p.product_name,
       p.price,
       round(ac.avg_price) as avg_price
from products p
inner join avg_category ac on p.category = ac.category and p.price > ac.avg_price
order by p.id
;

-- TODO 4: 부서별 최고 연봉자의 이름과 급여
-- 출력: 부서명, 직원명, 급여
-- 힌트: 서브쿼리 + JOIN 또는 윈도우 함수
SELECT A.dept_name,
       A.name,
       A.salary
FROM (
         select d.dept_name,
                e.name,
                e.salary,
                ROW_NUMBER() over (partition by e.department_id order by e.salary desc) as r
         from departments d
                  inner join employees e on d.id = e.department_id
     ) AS A
WHERE A.r = 1
ORDER BY 1;


-- TODO 5: 2024년 1월, 2월, 3월의 월별 총 매출을 가로로 출력 (피벗)
-- 출력: 1월매출, 2월매출, 3월매출
-- 힌트: CASE WHEN + SUM
SELECT 1;


-- ========================================
-- 고급 (6-12) ⭐⭐⭐
-- ========================================

-- TODO 6: 각 상품의 일별 누적 판매 수량 (2024-01-01 ~ 2024-03-31)
-- 출력: 상품ID, 날짜, 당일판매량, 누적판매량
-- 힌트: SUM() OVER (PARTITION BY ... ORDER BY ...)
select  s.product_id,
        s.sale_date,
        s.quantity,
        sum(s.quantity) over (partition by s.product_id order by s.sale_date) as r
from sales s
-- group by s.product_id,
order by 1, 2


-- TODO 7: 전월 대비 매출 증감률 (2024년 1,2,3월)
-- 출력: 년월, 당월매출, 전월매출, 증감률(%)
-- 힌트: LAG() 윈도우 함수
WITH B AS (

        SELECT  A.date,
                A.amount,
                LAG(A.amount) over (ORDER BY A.date) AS before_month_amount
          FROM (
                   select  date_format(s.sale_date, '%Y-%m') as date,
                           sum(s.amount) as amount
                   from sales s
                   group by 1
               ) AS A
)
SELECT B.date,
       B.amount,
       B.before_month_amount,
       ((B.amount - B.before_month_amount) / B.before_month_amount) * 100 AS increase
FROM B;

-- TODO 8: 각 고객 등급(VIP, GOLD, SILVER, BRONZE)별 비율(%)
-- 출력: 등급, 고객수, 비율
-- 힌트: COUNT() / (SELECT COUNT(*) FROM customers)
select c.grade,
       count(1),
       round(count(1) /  (select count(1) from customers) * 100, 2)

from customers c
group by c.grade
;

-- TODO 9: 직원별 직속 부하 직원 수 계산
-- 출력: 매니저명, 부하직원수
-- 힌트: GROUP BY manager_id
Sselect e.manager_id,
       ee.name,
       count(1)

  from employees e
 inner join employees ee on e.manager_id = ee.id
group by 1, 2
;


-- TODO 10: 최근 3개월 이동 평균 매출 (월별)
-- 출력: 년월, 당월매출, 3개월이동평균
-- 힌트: AVG() OVER (ORDER BY ... ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
SELECT 1;


-- TODO 11: 상품별 매출 순위 (같은 금액이면 같은 순위, 다음 순위는 건너뜀)
-- 출력: 순위, 상품명, 총매출액
-- 힌트: RANK()
SELECT 1;


-- TODO 12: 각 부서에서 급여 상위 30% 안에 드는 직원
-- 출력: 부서명, 직원명, 급여, 백분위
-- 힌트: NTILE(10) OVER (PARTITION BY ...)
SELECT 1;


-- ========================================
-- 최상급 (13-20) ⭐⭐⭐⭐
-- ========================================

-- TODO 13: 재귀 쿼리로 조직도 생성 (CEO부터 모든 하위 직원까지)
-- 출력: 직원명, 레벨, 경로(CEO > 본부장 > 팀장 > 사원)
-- 힌트: WITH RECURSIVE


SELECT 1;


-- TODO 14: 연속으로 3일 이상 매출이 발생한 상품 찾기
-- 출력: 상품ID, 상품명, 연속일수
-- 힌트: LAG() + 날짜 계산


SELECT 1;


-- TODO 15: 각 월의 매출 Top 3 상품
-- 출력: 년월, 순위, 상품명, 매출액
-- 힌트: RANK() OVER (PARTITION BY 년월 ORDER BY 매출 DESC) + WHERE rank <= 3


SELECT 1;


-- TODO 16: 고객의 첫 구매일과 마지막 구매일 사이의 일수, 그리고 총 구매 금액
-- 출력: 고객명, 첫구매일, 마지막구매일, 경과일수, 총구매금액
-- 힌트: DATEDIFF(), MIN(), MAX()


SELECT 1;


-- TODO 17: 부서별 평균 급여보다 높은 급여를 받는 직원의 수와 비율
-- 출력: 부서명, 기준평균급여, 초과인원, 전체인원, 비율(%)


SELECT 1;


-- TODO 18: 월별 신규 고객 수와 누적 고객 수
-- 출력: 년월, 신규고객수, 누적고객수
-- 힌트: COUNT() + SUM() OVER (ORDER BY ...)


SELECT 1;


-- TODO 19: 상품 카테고리별 매출 비중(%) (2024년 전체 기준)
-- 출력: 카테고리, 매출액, 비중(%)
-- 소수점 2자리까지


SELECT 1;


-- TODO 20: 각 직원의 입사 순위와 동일 부서 내 입사 순위
-- 출력: 직원명, 부서명, 입사일, 전사입사순위, 부서내입사순위
-- 힌트: ROW_NUMBER() 두 번 사용


SELECT 1;
