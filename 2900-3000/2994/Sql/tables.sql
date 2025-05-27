CREATE TABLE doctors (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE work_shifts (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50),
  bonus NUMERIC
);

CREATE TABLE attendances (
  id INTEGER PRIMARY KEY,
  id_doctor INTEGER,
  hours INTEGER,
  id_work_shift INTEGER,
  FOREIGN KEY (id_doctor) REFERENCES doctors(id),
  FOREIGN KEY (id_work_shift) REFERENCES work_shifts(id)
);
