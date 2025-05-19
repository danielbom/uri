CREATE TABLE candidate (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE score (
  candidate_id INTEGER PRIMARY KEY,
  math NUMERIC,
  specific NUMERIC,
  project_plan NUMERIC
);
