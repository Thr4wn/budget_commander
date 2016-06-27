here=`dirname $0`
psql -d ppfm -U sbird -H -c "select * from report_subaccount_balances()" > $here/../private/report.html
psql -d ppfm -U sbird -H -c "select * from report_account_balances()" >> $here/../private/report.html
psql -d ppfm -U sbird -H -c "select * from report_category_balances()" >> $here/../private/report.html
psql -d ppfm -U sbird -H -c "select * from report_month_spendings(-1)" >> $here/../private/report.html
# are spendings within budget?

#TODO: upload reports to dropbox.

