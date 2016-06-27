DROP TABLE activity;
CREATE TABLE activity (
    -- day transaction took place.
    day DATE,

    -- free form description. By default, it's what the bank statement has as the description.
    description TEXT,

    -- the amount the activity entry is.
    -- Read main README for more about what negative or positive values mean.
    amount NUMERIC(11,2),

    -- read main README.md for more info about categories
    category TEXT,

    -- read main README.md for more info about accounts
    account TEXT,

    -- read main README.md for more info about subaccounts
    subaccount TEXT,

    -- 'comments' is free form text with absolutely no assumptions about it's use.
    comments TEXT,

    -- 'stage' is for marking activity which is staged and not official.
    -- For example, during imports, activity is staged before becoming official.
    -- Empty string means it's official and not staged.
    -- NOT NULL because we don't want false assumptions or mistakes messing up data.
    stage TEXT NOT NULL
);

-- Whenever external activity is imported, someone needs to manually work the data.
-- Things that need to be done are described in management/README.md.
-- the purpose of pre_activity is to have a place where activity can be controlled before becoming official
DROP TABLE importedActivity;
CREATE TABLE importedActivity ( like activity );

DROP TABLE budget;
CREATE TABLE budget (
    item TEXT CONSTRAINT uq_budget UNIQUE,
    expected NUMERIC(11,2),
    situation TEXT
);

