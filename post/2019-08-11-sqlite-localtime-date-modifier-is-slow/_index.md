+++
Title = "SQLite Localtime Date Modifier is Slow"
Excerpt = ""
CreatedAt = "2019-08-11 10:57:22 +0700"
UpdatedAt = "2019-08-11 10:57:22 +0700"
Category = "programming"
Tags = ["sqlite"]
Author = "Radhi Fadlillah"
+++

Today I found a weird bug in my company's dashboard app where it took a long time to load data from SQLite database. The number of data is not too many (only around 400k> rows), yet it took several seconds to load. This is really weird, especially considering SQLite is famous for its reading speed. Turn out, this issue is happened because I was using `localtime` date modifier in my `SELECT` query.

Our dashboard app has a table called `purchase` that used to contains the purchase history from our consumer and (kind of) structured like this :

| Column Name | Type    | Description                           |
|:-----------:|:-------:|---------------------------------------|
| id          | INTEGER | The purchase ID                       |
| qty         | INTEGER | Count of purchased products           |
| total       | INTEGER | Total price of the purchased products |
| input_time  | TEXT    | Time of transaction in UTC time       |

Since the purchase history is saved in UTC, when user want to see the purchased items between two periods, the app must convert `input_time` into local time, filter it, then send the result to user. This is how we query it back then :

```sql
SELECT COUNT(*) FROM purchase
WHERE DATE(input_time, "localtime") >= "2019-01-01"
AND DATE(input_time, "localtime") <= "2019-08-10";
```

Since this query is really slow, I started looking for another alternative. I found that SQLite has `NNN hours` [modifier](https://sqlite.org/lang_datefunc.html) which simply add `NNN` hours int the date time column. So, to replace `localtime` modifier I only need to find current timezone offset (in my case its +7 from UTC) then put it into the query. The new query now look like this :

```sql
SELECT COUNT(*) FROM purchase
WHERE DATE(input_time, "+7 hours") >= "2019-01-01"
AND DATE(input_time, "+7 hours") <= "2019-08-10";
```

Turns out this new query is far faster than the previous query that uses `localtime` modifier. I tried to do some  benchmark by populating the `purchase` table with several thousand data, then query it using both modifier. From the result I found that `NNN hours` modifier is around 5x faster than `localtime` modifier :

```
N Days    : 10
Rows      : 2649
Localtime : 3.522 s
Hours     : 0.641 s
Hours is 5.49x faster than Localtime

N Days    : 20
Rows      : 5059
Localtime : 3.533 s
Hours     : 0.634 s
Hours is 5.57x faster than Localtime

N Days    : 40
Rows      : 9831
Localtime : 3.503 s
Hours     : 0.616 s
Hours is 5.69x faster than Localtime

N Days    : 80
Rows      : 19481
Localtime : 3.532 s
Hours     : 0.633 s
Hours is 5.58x faster than Localtime

N Days    : 160
Rows      : 38674
Localtime : 3.501 s
Hours     : 0.636 s
Hours is 5.50x faster than Localtime

N Days    : 320
Rows      : 77206
Localtime : 3.590 s
Hours     : 0.658 s
Hours is 5.46x faster than Localtime

N Days    : 640
Rows      : 154173
Localtime : 3.598 s
Hours     : 0.658 s
Hours is 5.47x faster than Localtime

N Days    : 1280
Rows      : 308009
Localtime : 3.568 s
Hours     : 0.658 s
Hours is 5.42x faster than Localtime

N Days    : 2560
Rows      : 615760
Localtime : 3.657 s
Hours     : 0.665 s
Hours is 5.50x faster than Localtime
```

With that said, when working with date and time in SQLite it might be better to use `NNN hours` than the `localtime` modifier.
