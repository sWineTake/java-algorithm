-- 데이터베이스 초기화
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 부서 테이블
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- 직원 테이블
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    department_id INT,
    salary INT NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- 고객 테이블
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(50),
    join_date DATE NOT NULL
);

-- 상품 테이블
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price INT NOT NULL,
    stock INT NOT NULL
);

-- 주문 테이블
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 샘플 데이터: 부서
INSERT INTO departments (dept_name, location) VALUES
    ('개발팀', '서울'),
    ('영업팀', '부산'),
    ('인사팀', '서울'),
    ('마케팅팀', '대전');

-- 샘플 데이터: 직원
INSERT INTO employees (name, department_id, salary, hire_date) VALUES
    ('김철수', 1, 5000, '2020-01-15'),
    ('이영희', 1, 6000, '2019-03-20'),
    ('박민수', 2, 4500, '2021-06-10'),
    ('최지영', 1, 5500, '2020-11-05'),
    ('정대호', 2, 4800, '2021-02-14'),
    ('홍길동', 3, 4200, '2022-01-20'),
    ('김영수', 3, 4300, '2021-08-15'),
    ('이민지', 4, 5200, '2020-05-10'),
    ('박서준', 4, 5300, '2020-07-22'),
    ('최수진', 1, 7000, '2018-04-10'),
    ('정현우', 2, 5000, '2021-03-15'),
    ('윤서아', 1, 6500, '2019-09-25'),
    ('강태희', 2, 4600, '2022-02-10'),
    ('송지훈', 3, 4400, '2021-12-01'),
    ('임수빈', 4, 5400, '2020-10-18');

-- 샘플 데이터: 고객
INSERT INTO customers (name, email, city, join_date) VALUES
    ('고객A', 'a@test.com', '서울', '2023-01-10'),
    ('고객B', 'b@test.com', '부산', '2023-02-15'),
    ('고객C', 'c@test.com', '서울', '2023-03-20'),
    ('고객D', 'd@test.com', '대전', '2023-04-05'),
    ('고객E', 'e@test.com', '서울', '2023-05-12'),
    ('고객F', 'f@test.com', '광주', '2023-06-18'),
    ('고객G', 'g@test.com', '서울', '2023-07-22'),
    ('고객H', 'h@test.com', '부산', '2023-08-30'),
    ('고객I', 'i@test.com', '대전', '2023-09-14'),
    ('고객J', 'j@test.com', '서울', '2023-10-25');

-- 샘플 데이터: 상품
INSERT INTO products (product_name, category, price, stock) VALUES
    ('노트북', '전자제품', 1200000, 50),
    ('마우스', '전자제품', 25000, 200),
    ('키보드', '전자제품', 80000, 150),
    ('모니터', '전자제품', 350000, 80),
    ('의자', '가구', 250000, 100),
    ('책상', '가구', 400000, 60),
    ('스탠드', '가구', 50000, 120),
    ('헤드셋', '전자제품', 100000, 90),
    ('웹캠', '전자제품', 80000, 70),
    ('USB', '전자제품', 15000, 300);

-- 샘플 데이터: 주문
INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
    (1, 1, 1, '2024-01-10'),
    (1, 2, 2, '2024-01-15'),
    (2, 3, 1, '2024-01-20'),
    (3, 1, 1, '2024-02-05'),
    (3, 4, 1, '2024-02-10'),
    (4, 5, 2, '2024-02-15'),
    (5, 6, 1, '2024-02-20'),
    (6, 7, 3, '2024-03-01'),
    (7, 1, 1, '2024-03-10'),
    (8, 8, 2, '2024-03-15'),
    (9, 9, 1, '2024-03-20'),
    (10, 10, 5, '2024-03-25'),
    (1, 3, 1, '2024-04-01'),
    (2, 5, 1, '2024-04-05'),
    (3, 2, 3, '2024-04-10'),
    (4, 1, 1, '2024-04-15'),
    (5, 4, 1, '2024-04-20'),
    (6, 8, 1, '2024-04-25'),
    (7, 6, 1, '2024-05-01'),
    (8, 7, 2, '2024-05-05');
