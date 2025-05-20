CREATE TABLE teams (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE matches (
  id INTEGER PRIMARY KEY,
  team_1 INTEGER,
  team_2 INTEGER,
  team_1_goals INTEGER,
  team_2_goals INTEGER,
  FOREIGN kEY (team_1) REFERENCES teams(id),
  FOREIGN kEY (team_2) REFERENCES teams(id)
);
