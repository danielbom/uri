-- Query 1

WITH cities_ranked AS (
  SELECT c.id, c.city_name, c.population
      , ROW_NUMBER() OVER (ORDER BY c.population DESC) rank_up
      , ROW_NUMBER() OVER (ORDER BY c.population ASC) rank_down
  FROM cities c
)
SELECT c.city_name, c.population
FROM cities_ranked c
WHERE c.rank_up = 2 OR c.rank_down = 2
ORDER BY c.population DESC;

-- Query 2

(SELECT c.city_name, c.population
FROM cities c
ORDER BY c.population DESC
OFFSET 1 LIMIT 1)
  UNION ALL
(SELECT c.city_name, c.population
FROM cities c
ORDER BY c.population ASC
OFFSET 1 LIMIT 1);

-- ChatGPT explanations

WITH cities_ranked AS (
  SELECT c.id, c.city_name, c.population
      -- forces a unique sequence, even for ties
      , ROW_NUMBER() OVER (ORDER BY c.population DESC) index_up
      , ROW_NUMBER() OVER (ORDER BY c.population ASC) index_down
      -- assigns the same rank to tied values
      -- + skip values during ranking: 1 2 2 4 
      , RANK() OVER (ORDER BY c.population DESC) rank_up
      , RANK() OVER (ORDER BY c.population ASC) rank_down
      -- + does not skip values during ranking: 1 2 2 3 
      , DENSE_RANK() OVER (ORDER BY c.population DESC) drank_up
      , DENSE_RANK() OVER (ORDER BY c.population ASC) drank_down
  FROM cities c
)
SELECT c.city_name, c.population
FROM cities_ranked c
WHERE c.index_up = 2 OR c.index_down = 2
ORDER BY c.population DESC;
