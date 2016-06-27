
---------------------------------------
-- Balances
---------------------------------------

DROP FUNCTION report_account_balances();
CREATE OR REPLACE FUNCTION report_account_balances() RETURNS TABLE(account TEXT, balance NUMERIC(11,2)) AS $$
DECLARE
BEGIN
    RETURN QUERY SELECT activity.account, SUM(amount) as total FROM activity WHERE activity.account<>'' GROUP BY activity.account ORDER BY total DESC;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION report_subaccount_balances();
CREATE OR REPLACE FUNCTION report_subaccount_balances() RETURNS TABLE(subaccount TEXT, balance NUMERIC(11,2)) AS $$
DECLARE
BEGIN
    RETURN QUERY SELECT activity.subaccount, SUM(amount) as total FROM activity WHERE activity.subaccount<>'' GROUP BY activity.subaccount ORDER BY total DESC;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION report_category_balances();
CREATE OR REPLACE FUNCTION report_category_balances() RETURNS TABLE(category TEXT, balance NUMERIC(11,2)) AS $$
DECLARE
BEGIN
    RETURN QUERY SELECT activity.category, SUM(amount) as total FROM activity WHERE activity.category <>'' GROUP BY activity.category  ORDER BY total DESC;
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

DROP FUNCTION report_month_spendings(int);
CREATE OR REPLACE FUNCTION report_month_spendings(months_ago Integer) RETURNS TABLE(category TEXT, percentage NUMERIC(2,2), spent NUMERIC(11,2), expected NUMERIC(11,2), leftover NUMERIC(11,2)) AS $$
DECLARE
    total NUMERIC(11,2);
    month_end DATE := date_trunc('month', now()::date) - (to_char(months_ago, '9999999999') || ' month')::INTERVAL;
    month_start DATE := date_trunc('month', now()::date) - (to_char(months_ago+1, '9999999999') || ' month')::INTERVAL;
BEGIN
    SELECT sum(amount) INTO total FROM activity WHERE amount < 0 AND day >= month_start AND day < month_end;

    RETURN QUERY SELECT
      activity.category as cat,
      SUM(amount)/total as percentage,
      0-SUM(amount) as spent,
      budget.expected,
      coalesce(budget.expected, 0) - (0-SUM(amount)) as leftover
    FROM activity left join budget on activity.category = budget.item
    WHERE
      activity.category<>''
      AND activity.amount<0
      AND day >= month_start
      AND day < month_end
    GROUP BY activity.category, budget.expected order by spent desc;
END;
$$ LANGUAGE plpgsql;

