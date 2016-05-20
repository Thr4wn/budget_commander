
def run_sql(sql)
    cmd = "psql -U sbird -d ppfm -c \"#{sql}\""
    unless system(cmd)
        raise Exception.new("sql command failed: #{cmd}")
    end
end
def budget(topic, item, amount=nil, situation=nil)
    unless $after_first_run
        $after_first_run = true
        run_sql "DELETE FROM budget"
    end
    amount ||= yield || "NULL"
    situation ||= "NULL"
    run_sql "INSERT INTO budget (topic, item, amount, situation) VALUES ('#{topic}', '#{item}', #{amount}, '#{situation}');"
end
