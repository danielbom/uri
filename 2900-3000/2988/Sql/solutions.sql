-- Solution 1
WITH score as (
  SELECT s.team_id, 
    SUM(s.match) as matches,
    SUM(s.victory) as victories,
    SUM(s.defeat) as defeats,
    SUM(s.draw) as draws,
    SUM(s.victory * 3 + s.draw * 1) as score
  FROM ((SELECT m.team_1 as team_id,
        COUNT(1) as match,
        SUM(CASE WHEN m.team_1_goals > m.team_2_goals THEN 1 ELSE 0 END) AS victory,
        SUM(CASE WHEN m.team_1_goals < m.team_2_goals THEN 1 ELSE 0 END) AS defeat,
        SUM(CASE WHEN m.team_1_goals = m.team_2_goals THEN 1 ELSE 0 END) AS draw
        FROM matches m
        GROUP BY m.team_1)
          UNION
        (SELECT m.team_2 as team_id,
        COUNT(1) as match,
        SUM(CASE WHEN m.team_2_goals > m.team_1_goals THEN 1 ELSE 0 END) AS victory,
        SUM(CASE WHEN m.team_2_goals < m.team_1_goals THEN 1 ELSE 0 END) AS defeat,
        SUM(CASE WHEN m.team_2_goals = m.team_1_goals THEN 1 ELSE 0 END) AS draw
        FROM matches m
        GROUP BY m.team_2)) s
  GROUP BY s.team_id)
SELECT t.name, s.matches, s.victories, s.defeats, s.draws, s.score
FROM teams t
JOIN score s ON s.team_id = t.id
ORDER BY s.score DESC;

-- Solution 2
SELECT s.*, (s.victories*3 + s.draws*1) as score
FROM (SELECT t.name,
  (SELECT COUNT(1) FROM matches m WHERE m.team_1 = t.id OR m.team_2 = t.id) AS matches,
  (SELECT COUNT(1) FROM matches m WHERE (m.team_1 = t.id AND m.team_1_goals > m.team_2_goals) OR (m.team_2 = t.id AND m.team_1_goals < m.team_2_goals)) as victories,
  (SELECT COUNT(1) FROM matches m WHERE (m.team_1 = t.id AND m.team_1_goals < m.team_2_goals) OR (m.team_2 = t.id AND m.team_1_goals > m.team_2_goals)) as defeats,
  (SELECT COUNT(1) FROM matches m WHERE (m.team_1 = t.id OR m.team_2 = t.id) AND m.team_1_goals = m.team_2_goals) as draws
FROM teams t) s
ORDER BY score DESC;

-- Solution 3
SELECT t.name,
  (SELECT COUNT(1) FROM matches m WHERE m.team_1 = t.id OR m.team_2 = t.id) AS matches,
  (SELECT COUNT(1) FROM matches m WHERE (m.team_1 = t.id AND m.team_1_goals > m.team_2_goals) OR (m.team_2 = t.id AND m.team_1_goals < m.team_2_goals)) as victories,
  (SELECT COUNT(1) FROM matches m WHERE (m.team_1 = t.id AND m.team_1_goals < m.team_2_goals) OR (m.team_2 = t.id AND m.team_1_goals > m.team_2_goals)) as defeats,
  (SELECT COUNT(1) FROM matches m WHERE (m.team_1 = t.id OR m.team_2 = t.id) AND m.team_1_goals = m.team_2_goals) as draws,
  (SELECT SUM(CASE 
    WHEN m.team_1 = t.id AND m.team_1_goals > m.team_2_goals THEN 3
    WHEN m.team_2 = t.id AND m.team_1_goals < m.team_2_goals THEN 3
    WHEN m.team_1_goals = m.team_2_goals THEN 1
    ELSE 0
    END) FROM matches m WHERE (m.team_1 = t.id OR m.team_2 = t.id))
FROM teams t;

-- ChatGPT Improviment of Solution 1
WITH match_results AS (
  SELECT m.team_1 AS team_id,
    CASE WHEN m.team_1_goals > m.team_2_goals THEN 1 ELSE 0 END AS victory,
    CASE WHEN m.team_1_goals < m.team_2_goals THEN 1 ELSE 0 END AS defeat,
    CASE WHEN m.team_1_goals = m.team_2_goals THEN 1 ELSE 0 END AS draw
  FROM matches m
  UNION ALL
  SELECT m.team_2 AS team_id,
    CASE WHEN m.team_2_goals > m.team_1_goals THEN 1 ELSE 0 END AS victory,
    CASE WHEN m.team_2_goals < m.team_1_goals THEN 1 ELSE 0 END AS defeat,
    CASE WHEN m.team_2_goals = m.team_1_goals THEN 1 ELSE 0 END AS draw
  FROM matches m),
scores AS (
  SELECT team_id,
    COUNT(team_id) AS matches,
    SUM(victory) AS victories,
    SUM(defeat) AS defeats,
    SUM(draw) AS draws,
    SUM(victory) * 3 + SUM(draw) AS score
  FROM match_results
  GROUP BY team_id)
SELECT t.name, s.matches, s.victories, s.defeats, s.draws, s.score
FROM teams t
JOIN scores s ON s.team_id = t.id
ORDER BY s.score DESC;
