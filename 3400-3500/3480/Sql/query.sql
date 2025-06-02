SELECT l.queue, l.id as left, r.id as right
FROM chairs l
JOIN chairs r ON r.queue = l.queue AND r.id = l.id+1
LEFT JOIN chairs ll ON ll.queue = l.queue AND ll.id = l.id-1
LEFT JOIN chairs rr ON rr.queue = r.queue AND rr.id = r.id+1
WHERE l.available AND r.available
  AND (ll.available IS NULL OR NOT ll.available)
  AND (rr.available IS NULL OR NOT rr.available)
ORDER BY l.id;
