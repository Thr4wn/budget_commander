
CREATE TABLE temp (
    day DATE,
    description TEXT,
    amount NUMERIC(11,2),
    account TEXT,
    comments TEXT,
    subaccount TEXT,
    category TEXT
);

COPY temp FROM '/Users/sbird/code/ppfm/private/imported.csv' DELIMITER ',' CSV;

INSERT INTO activity (
    day,
    description,
    amount,
    account,
    comments,
    subaccount,
    category
)
SELECT
    day,
    description,
    amount,
    account,
    comments,
    subaccount,
    category
FROM temp;

DROP TABLE temp;

