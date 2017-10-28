---
id: 72
title: "Auto-increment counter not persisted on disk with InnoDB"
date: 2016-10-05 10:30:00 +0100
author: Dalibor Nasevic
tags: [auto-increment, innodb, mysql]
summary: "Auto-increment counter is not persisted on disk with InnoDB engine. That can lead to some surprising bugs like what this story is about."
---

**Note**: This [issue](https://bugs.mysql.com/bug.php?id=199) has been fixed in MySQL 8.0.0, 14 years after the original bug report.

Few weeks ago I hit an interesting bug in production that made me wonder is time-travel real!? I was seeing activities for emails before the emails were actually sent...

How is that even possible I was wondering!?

It turns out, InnoDB [does not persist](http://dev.mysql.com/doc/refman/5.7/en/innodb-auto-increment-handling.html) the auto-increment counter on disk.

> If you specify an <strong>AUTO_INCREMENT</strong> column for an <strong>InnoDB</strong> table, the table handle in the <strong>InnoDB</strong> data dictionary contains a special counter called the auto-increment counter that is used in assigning new values for the column. This counter is stored <strong>only in main memory, not on disk</strong>.

> To initialize an auto-increment counter after a server restart, <strong>InnoDB</strong> executes the equivalent of the following statement on the first insert into a table containing an <strong>AUTO_INCREMENT</strong> column.

> `SELECT MAX(ai_col) FROM table_name FOR UPDATE;`

After reading the above documentation, I had a light-bulb moment.


### More context

I have one temporary table in the system that is regularly cleaned removing old unnecessary data to take care of disk space usage. It's a multi-tenant architecture in which each user has it's own database and when user is inactive for a period of time, one of their tables becomes empty after cron task deletes data.

One of the physical servers running few MySQL instances was having memory issues that caused some instances to restart. After restart, the `AUTO_INCREMENT` value for the empty table got reset to 0 and newly inserted records were with IDs that were already used.


### Fixing it

Knowing the issue, the solution is pretty straight-forward. When cleaning the table, leave the last record in there, so that if server crashes and restarts again, the `AUTO_INCREMENT` value will get initialized to the correct value instead of getting reset to 0.

Fixing the incorrect `AUTO_INCREMENT` counters for the table involves figuring out a safe max INT value based on relations that the table has with other tables in the database and changing it. Also, a dummy record needs to be inserted in cleaned empty tables to prevent the issue from happening again if server crashed again before new data is inserted in the table.

To get the auto-increment value for a table:

```sql
SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name = 'table_name' AND table_schema = DATABASE();
```

To set the auto-increment value for a table:

```sql
ALTER TABLE table_name AUTO_INCREMENT = new_value;
```


### Final thoughts

It's surprising to learn about this `AUTO_INCREMENT` behaviour with InnoDB that is unexpected in my opinion. It's even more surprising when it comes after a year in production, but that's just because the database servers and application have been rock solid in general. Luckily, it was an isolated case and was fixed quickly to prevent further data damage that will require more serious data fix. Just something to be aware of and design around this flaw to prevent it bite you.
