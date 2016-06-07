CREATE OR REPLACE FUNCTION update_budget() RETURNS void AS $$
DECLARE
    ---------------
    --
    ---------------
    net_income numeric(11,2) := 4400.00;


    ---------------
    -- bills
    ---------------
    electric numeric(11,2) := 192;
    nat_gas numeric(11,2) := 40;
    internet numeric(11,2) := 55;
    trash numeric(11,2) := 0;
    phone numeric(11,2) := 70;
    nationwide numeric(11,2) := 262.43;
    rent numeric(11,2) := 1675;
    ----
    bills numeric(11,2) := electric+nat_gas+internet+trash+phone+nationwide+rent;


    ---------------
    -- gift
    ---------------
    normal_gift numeric(11,2) := 15.00;
    christmas numeric(11,2) := 120.00;
    ----
    gift numeric(11,2) := normal_gift*2;


    ---------------
    -- donations
    ---------------
    ten_precent_net numeric(11,2) := net_income*.1;

    emmaus numeric(11,2) := 100.00;
    laskowski numeric(11,2) := 75.00;
    larry_hope numeric(11,2) := 75.00;
    church_on_the_street numeric(11,2) := 52.50;
      donations_so_far numeric(11,2) := emmaus + laskowski + larry_hope + church_on_the_street;
    tithe numeric(11,2) := greatest(0, ten_precent_net - donations_so_far);
    ----
    donations numeric(11,2) := donations_so_far + tithe;


    ---------------
    -- food
    ---------------
    previous_food_usage numeric(11,2) := 630.00;
    food numeric(11,2) := previous_food_usage;

BEGIN
    --CREATE TABLE budget2 AS TABLE budget;
    DELETE FROM budget;

    INSERT INTO budget (topic, amount, situation) VALUES ('bills', bills, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('gift', gift, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('donations', donations, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('food', food, NULL); --TODO: 'previous usage' is actually calculated

END;
$$ LANGUAGE plpgsql;
