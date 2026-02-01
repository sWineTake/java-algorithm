# 🔥 MySQL 실전 코딩테스트 (난이도 상)

## 📝 문제 설명

**총 문제 수**: 20개  
**제한 시간**: 2시간  
**난이도**: 중급 → 최상급

실전 코테와 실무에서 나오는 어려운 MySQL 쿼리!

---

## ⚠️ 난이도

- ⭐⭐ 중급 (1-5): 복잡한 JOIN, 서브쿼리
- ⭐⭐⭐ 고급 (6-12): 윈도우 함수, Self JOIN, 복잡한 집계
- ⭐⭐⭐⭐ 최상급 (13-20): 재귀 쿼리, 이동 평균, 누적 합계, 복잡한 비즈니스 로직

---

## 🗄️ 데이터베이스

### 테이블 (6개)
- **employees** - 직원 (20명, 계층 구조)
- **departments** - 부서 (5개)
- **sales** - 매출 (50건)
- **products** - 상품 (15개)
- **customers** - 고객 (30명)
- **order_items** - 주문 상세 (100건)

---

## 🚀 실행

```bash
# MySQL 실행
docker run -d --name mysqlhard \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=testdb \
  -p 3306:3306 \
  mysql:8.0

# DB 초기화
sleep 10
docker exec -i mysqlhard mysql -uroot -proot testdb < schema.sql

# 접속
docker exec -it mysqlhard mysql -uroot -proot testdb
```

---

**Good Luck! 🔥**

이번엔 진짜 어렵습니다!
