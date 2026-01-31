# 🗄️ MySQL 쿼리 코딩테스트 (20문제)

## 📝 문제 설명

**총 문제 수**: 20개  
**제한 시간**: 90분  
**난이도**: 기초 → 고급

MySQL 쿼리 작성 능력을 마스터하세요!

---

## 📂 파일 구성

- `schema.sql` - DB 스키마 + 샘플 데이터
- `problems.sql` - TODO 20개 문제
- `ANSWER.sql` - 정답

---

## 🗄️ 데이터베이스 구조

### 테이블 (5개)
1. **departments** - 부서 (4개)
2. **employees** - 직원 (15명)
3. **customers** - 고객 (10명)
4. **products** - 상품 (10개)
5. **orders** - 주문 (20건)

---

## 📊 난이도별 분류

### Part 1: 기초 (1-7) - 20분
- SELECT, WHERE, ORDER BY
- 기본 집계 함수
- LIMIT, DISTINCT

### Part 2: 중급 (8-14) - 35분
- JOIN (INNER, LEFT, RIGHT)
- GROUP BY, HAVING
- 다중 테이블 조인

### Part 3: 고급 (15-20) - 35분
- 서브쿼리
- 윈도우 함수
- CTE (WITH)
- CASE WHEN

---

## 🚀 실행 방법

```bash
# 1. MySQL 실행
docker run -d --name mysqltest \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=testdb \
  -p 3306:3306 \
  mysql:8.0

# 2. DB 초기화
sleep 10
docker exec -i mysqltest mysql -uroot -proot testdb < schema.sql

# 3. MySQL 접속
docker exec -it mysqltest mysql -uroot -proot testdb

# 4. 문제 풀기
source problems.sql
```

---

## 💡 학습 목표

### 기본
- SELECT, WHERE, ORDER BY
- COUNT, SUM, AVG, MAX, MIN
- LIMIT, DISTINCT

### 중급
- INNER JOIN, LEFT JOIN
- GROUP BY, HAVING
- CONCAT, DATE 함수

### 고급
- 서브쿼리 (IN, EXISTS)
- 윈도우 함수 (RANK, ROW_NUMBER)
- CTE (WITH RECURSIVE)

---

**Good Luck! 💪**

각 문제마다 예상 결과가 주석으로 있습니다!
