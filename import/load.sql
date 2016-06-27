
CREATE OR REPLACE FUNCTION activity_import(file TEXT) RETURNS void AS $$
DECLARE
BEGIN
    COPY activity FROM file DELIMITER ',' CSV;
END;
$$ LANGUAGE plpgsql;

