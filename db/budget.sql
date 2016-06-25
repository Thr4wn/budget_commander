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


    ---------------
    -- gas
    ---------------
    previous_gas_usage numeric(11,2) := 130.00;
    gas numeric(11,2) := previous_gas_usage;


    ---------------
    -- Sarah
    ---------------
    arbitary_sarah numeric(11,2) := 110.00;
    sarah numeric(11,2) := arbitary_sarah;


    ---------------
    -- Seth
    ---------------
    arbitary_seth numeric(11,2) := 110.00;
    seth numeric(11,2) := arbitary_seth;


    ---------------
    -- home
    ---------------
    arbitary_home numeric(11,2) := 50.00;
    home numeric(11,2) := arbitary_home;


    ---------------
    -- debt
    ---------------
    seth_car_payment_minimum NUMERIC(11,2) := 254.23;

BEGIN
    --CREATE TABLE budget2 AS TABLE budget;
    DELETE FROM budget;

    INSERT INTO budget (topic, amount, situation) VALUES ('bills', bills, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('gift', gift, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('donations', donations, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('food', food, NULL); --TODO: 'previous usage' is actually calculated
    INSERT INTO budget (topic, amount, situation) VALUES ('gas', gas, NULL); --TODO: 'previous usage' is actually calculated
    INSERT INTO budget (topic, amount, situation) VALUES ('Sarah', sarah, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('Seth', seth, NULL);
    INSERT INTO budget (topic, amount, situation) VALUES ('home', home, NULL);

END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION amatorize_amount(rate DOUBLE PRECISION, principle NUMERIC(11,2), time_periods INTEGER) RETURNS NUMERIC(11,2) AS $$
BEGIN
    return principle * (rate*power(1+rate,time_periods)) / (power(1+rate,time_periods) - 1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION amatorize_time_periods(amount NUMERIC(11,2), principle NUMERIC(11,2), rate DOUBLE PRECISION) RETURNS NUMERIC(11,2) AS $$
BEGIN
    -- a = p * (r*(1+r)^t) / ((1+r)^t - 1)  
    -- a*((1+r)^t - 1) = p*r*(1+r)^t
    -- a*(1+r)^t - a = p*r*(1+r)^t
    -- a*(1+r)^t = p*r*(1+r)^t + a 
    -- a*(1+r)^t - p*r*(1+r)^t = a 
    -- (1+r)^t * (a - p*r) = a 
    -- (1+r)^t = a / (a - p*r)
    -- t*ln(1+r) = ln(a) - ln(a - p*r)
    -- t = ( ln(a) - ln(a - p*r) ) / ln(1+r)

    return ( ln(amount) - ln(amount - principle*rate) ) / ln(1+rate);
END;
$$ LANGUAGE plpgsql;

