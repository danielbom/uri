SELECT q.name
FROM ((SELECT l.position, CONCAT('Podium: ', l.team) as name
      FROM league l
      ORDER BY l.position ASC
      LIMIT 3)
        UNION
      (SELECT l.position, CONCAT('Demoted: ', l.team) as name
      FROM league l
      ORDER BY l.position DESC
      LIMIT 2)) q
ORDER BY q.position ASC;
