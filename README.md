
ppfm : Programer's PFM (Personal Finance Management)
====================================================

1. `import/import.sh` : import activity/data from websites via vagrant, selenium (read import/README.me for more)
2. `management/manage.sh` : manage your finances (read management/README.me for more)
3. `reports/report.sh` : run reports of financial situation (read reports/README.me for more)

Fork this repo and change it according to your needs.


Financial Logic
---------------

### Accounts

Accounts represent your real, external accounts -- like savings accounts,
checking accounts, student loans, credit cards, etc. Anything which is "real".

They are tracked with single-entry logic. Account names always start with a "$"
sign.

 * If it's measuring debt (aka a 'credit' account), then it starts with "$-".
    Nagative values in those accounts represent more debt accrued; positive
    values means that debt is being payed off.

 * If it's measuring owned money (aka a 'debit' account), then it starts with
    "$+". Negative values mean more money is accrued, negative values mean
    money is taken away from the account.

**Capital** is the sum of all debit accounts.

### Subaccounts

Subaccounts allocate your money you have (capital). Subaccounts are never
supposed to be less than zero, and the sum of all subaccounts should equal your
capital (sum of all your money in all your accounts).

### Categories

Categories are ways to track your activity: both spendings and earnings. There
are no constraints on categories.

