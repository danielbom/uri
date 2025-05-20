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
