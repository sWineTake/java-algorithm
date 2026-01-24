# 대장균 3세대 찾기

## 문제 설명
대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 **부모 개체**, 분화가 되어 나온 개체를 **자식 개체**라고 합니다.

## 테이블 구조
### ECOLI_DATA

| Column name          | Type    | Nullable |
|---------------------|---------|----------|
| ID                  | INTEGER | FALSE    |
| PARENT_ID           | INTEGER | TRUE     |
| SIZE_OF_COLONY      | INTEGER | FALSE    |
| DIFFERENTIATION_DATE| DATE    | FALSE    |
| GENOTYPE            | INTEGER | FALSE    |

- `ID`: 대장균 개체의 ID
- `PARENT_ID`: 부모 개체의 ID (최초 개체는 NULL)
- `SIZE_OF_COLONY`: 개체의 크기
- `DIFFERENTIATION_DATE`: 분화되어 나온 날짜
- `GENOTYPE`: 개체의 형질

> 💡 최초의 대장균 개체의 `PARENT_ID`는 NULL 값입니다.

## 문제
3세대의 대장균의 ID(`ID`)를 출력하는 SQL 문을 작성해주세요.

### 조건
- 결과는 대장균의 ID에 대해 **오름차순 정렬**

## 예시

### 입력 데이터
| ID | PARENT_ID | SIZE_OF_COLONY | DIFFERENTIATION_DATE | GENOTYPE |
|----|-----------|----------------|---------------------|----------|
| 1  | NULL      | 10             | 2019-01-01          | 5        |
| 2  | NULL      | 2              | 2019-01-01          | 3        |
| 3  | 1         | 100            | 2020-01-01          | 4        |
| 4  | 2         | 16             | 2020-01-01          | 4        |
| 5  | 2         | 17             | 2020-01-01          | 6        |
| 6  | 4         | 101            | 2021-01-01          | 22       |
| 7  | 3         | 101            | 2022-01-01          | 23       |
| 8  | 6         | 1              | 2022-01-01          | 27       |

### 세대별 구조
- **1세대**: ID 1, ID 2 (PARENT_ID가 NULL)
- **2세대**: ID 3 (부모: 1), ID 4 (부모: 2), ID 5 (부모: 2)
- **3세대**: ID 6 (부모: 4), ID 7 (부모: 3)
- **4세대**: ID 8 (부모: 6)

### 출력 결과
| ID |
|----|
| 6  |
| 7  |
