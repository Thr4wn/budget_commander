DROP TABLE activity;
CREATE TABLE activity (
    day DATE,
    description TEXT,
    amount NUMERIC(11,2),
    category TEXT,
    account TEXT,
    subaccount TEXT,
    comments TEXT
);

DROP TABLE budget;
CREATE TABLE budget (
    topic TEXT,
    item TEXT CONSTRAINT uq_budget UNIQUE,
    expected NUMERIC(11,2),
    situation TEXT
);

