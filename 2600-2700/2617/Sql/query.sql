SELECT pt.name, pd.name
FROM providers pd
JOIN products pt ON pt.id_providers = pd.id
WHERE pd.name = 'Ajax SA';
