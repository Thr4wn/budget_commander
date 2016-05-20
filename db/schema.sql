DROP TABLE activity;
CREATE TABLE activity (
    "date" DATE,
    description VARCHAR(255),
    amount NUMERIC(11,2),
    category VARCHAR(255),
    account VARCHAR(255),
    comments VARCHAR(255)
);

DROP TABLE budget;
CREATE TABLE budget (
    topic VARCHAR(255),
    item VARCHAR(255) CONSTRAINT uq_budget UNIQUE,
    amount NUMERIC(11,2),
    situation VARCHAR(255)
);

