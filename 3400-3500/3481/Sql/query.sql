WITH RECURSIVE tree AS (
  SELECT c.node_id, 1 AS level
  FROM nodes c
  WHERE c.pointer IS NULL
    UNION
  SELECT n.node_id, t.level + 1 AS level
  FROM nodes n
  JOIN tree t ON t.node_id = n.pointer
),
tree_root AS (
  SELECT MAX(t.level) AS max_level
  FROM tree t 
)
SELECT t.node_id
    , (CASE 
    WHEN t.level = 1 THEN 'LEAF'
    WHEN t.level = r.max_level THEN 'ROOT'
    ELSE 'INNER'
    END) as type
FROM tree t
JOIN tree_root r ON TRUE
ORDER BY t.node_id;
