
---------------------------------------
-- Balances
---------------------------------------

CREATE OR REPLACE FUNCTION report_account_balances() RETURNS TABLE(account TEXT, balance NUMERIC(11,2)) AS $$
DECLARE
BEGIN
    RETURN QUERY SELECT activity.account, SUM(amount) as total FROM activity WHERE activity.account<>'' GROUP BY activity.account ORDER BY total DESC;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION report_subaccount_balances() RETURNS TABLE(subaccount TEXT, balance NUMERIC(11,2)) AS $$
DECLARE
BEGIN
    RETURN QUERY SELECT activity.subaccount, SUM(amount) as total FROM activity WHERE activity.subaccount<>'' GROUP BY activity.subaccount ORDER BY total DESC;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION report_category_balances() RETURNS TABLE(category TEXT, balance NUMERIC(11,2)) AS $$
DECLARE
BEGIN
    RETURN QUERY SELECT activity.category, SUM(amount) as total FROM activity WHERE activity.category<>'' GROUP BY activity.category ORDER BY total DESC;
END;
$$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION "report_all"()
-- RETURNS SETOF refcursor AS $$
-- DECLARE
--     accountRC refcursor;
--     subaccountRC refcursor;
--     categoryRC refcursor;
-- BEGIN
--     open accountRC FOR
--     SELECT * FROM report_account_balances();
--     RETURN NEXT accountRC;
-- 
--     open subaccountRC FOR
--     SELECT * FROM report_subaccount_balances();
--     RETURN NEXT subaccountRC;
-- 
--     open categoryRC FOR
--     SELECT * FROM report_category_balances();
--     RETURN NEXT categoryRC;
-- 
--     RETURN;
-- END;
-- $$ LANGUAGE 'plpgsql' VOLATILE;

---------------------------------------
-- Budget Comparison
---------------------------------------

drop function report_month_spendings(int);
CREATE OR REPLACE FUNCTION report_month_spendings(months_ago Integer) RETURNS TABLE(category TEXT, percentage NUMERIC(2,2), spent NUMERIC(11,2)) AS $$
DECLARE
    total NUMERIC(11,2) := 1000;
    month_start DATE := date_trunc('month', now()::date) - (to_char(months_ago, '9999999999') || ' month')::INTERVAL;
    month_end DATE := date_trunc('month', now()::date) - (to_char(months_ago+1, '9999999999') || ' month')::INTERVAL;
BEGIN
    RETURN QUERY SELECT activity.category, SUM(amount)/total, 0-SUM(amount) as spendings
    FROM activity left join budget on activity.category = item WHERE activity.category<>'' AND day >= month_start AND day < month_end
    GROUP BY activity.category order by spendings desc;
END;
$$ LANGUAGE plpgsql;

