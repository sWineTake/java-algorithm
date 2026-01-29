# 대장균 크기 분류하기

## 문제 설명

대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.

다음은 실험실에서 배양한 대장균들의 정보를 담은 `ECOLI_DATA` 테이블입니다.

### ECOLI_DATA 테이블 구조

| Column name | Type | Nullable |
|-------------|------|----------|
| ID | INTEGER | FALSE |
| PARENT_ID | INTEGER | TRUE |
| SIZE_OF_COLONY | INTEGER | FALSE |
| DIFFERENTIATION_DATE | DATE | FALSE |
| GENOTYPE | INTEGER | FALSE |

- `ID`: 대장균 개체의 ID
- `PARENT_ID`: 부모 개체의 ID
- `SIZE_OF_COLONY`: 개체의 크기
- `DIFFERENTIATION_DATE`: 분화되어 나온 날짜
- `GENOTYPE`: 개체의 형질

> 최초의 대장균 개체의 `PARENT_ID`는 NULL 값입니다.

## 문제

대장균 개체의 크기를 내림차순으로 정렬했을 때 다음과 같이 분류합니다:

- 상위 0% ~ 25%: `CRITICAL`
- 상위 26% ~ 50%: `HIGH`
- 상위 51% ~ 75%: `MEDIUM`
- 상위 76% ~ 100%: `LOW`

대장균 개체의 ID(`ID`)와 분류된 이름(`COLONY_NAME`)을 출력하는 SQL 문을 작성해주세요.

### 요구사항

- 결과는 개체의 ID에 대해 **오름차순** 정렬
- 총 데이터의 수는 4의 배수
- 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없음

## 예시

### 입력 테이블 (ECOLI_DATA)

| ID | PARENT_ID | SIZE_OF_COLONY | DIFFERENTIATION_DATE | GENOTYPE |
|----|-----------|----------------|---------------------|----------|
| 1 | NULL | 10 | 2019/01/01 | 5 |
| 2 | NULL | 2 | 2019/01/01 | 3 |
| 3 | 1 | 100 | 2020/01/01 | 4 |
| 4 | 2 | 16 | 2020/01/01 | 4 |
| 5 | 2 | 17 | 2020/01/01 | 6 |
| 6 | 4 | 101 | 2021/01/01 | 22 |
| 7 | 6 | 101 | 2022/01/01 | 23 |
| 8 | 6 | 1 | 2022/01/01 | 27 |

### 분류 기준

- **CRITICAL** (상위 0% ~ 25%): ID 6, ID 7
- **HIGH** (상위 26% ~ 50%): ID 3, ID 5
- **MEDIUM** (상위 51% ~ 75%): ID 1, ID 4
- **LOW** (상위 76% ~ 100%): ID 2, ID 8

### 출력 결과

| ID | COLONY_NAME |
|----|-------------|
| 1 | MEDIUM |
| 2 | LOW |
| 3 | HIGH |
| 4 | MEDIUM |
| 5 | HIGH |
| 6 | CRITICAL |
| 7 | CRITICAL |
| 8 | LOW |

## 풀이
```sql
-- 여기에 SQL 쿼리 작성
```
