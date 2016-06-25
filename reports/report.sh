here=`dirname $0`
psql -d ppfm -U sbird -H -c "select * from report_subaccount_balances()" > $here/../report.html
psql -d ppfm -U sbird -H -c "select * from report_account_balances()" >> $here/../report.html
psql -d ppfm -U sbird -H -c "select * from report_category_balances()" >> $here/../report.html
psql -d ppfm -U sbird -H -c "select * from report_month_spendings()" >> $here/../report.html

