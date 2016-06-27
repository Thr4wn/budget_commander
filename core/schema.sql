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

-- Whenever external activity is imported, someone needs to manually work the data.
-- Things that need to be done are described in management/README.md.
-- the purpose of pre_activity is to have a place where activity can be controlled before becoming official
DROP TABLE pre_activity;
CREATE TABLE pre_activity ( like activity );

DROP TABLE budget;
CREATE TABLE budget (
    item TEXT CONSTRAINT uq_budget UNIQUE,
    expected NUMERIC(11,2),
    situation TEXT
);

