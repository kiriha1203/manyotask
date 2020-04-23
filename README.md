# README

## Database

* テーブル名は太字

* キー属性のものはイタリック

*　非キー属性のものは通常文字

| **User**                |  
|-------------------------|
| *id*                    |
| name(string)            |
| email(string)           |
| password_digest(string) |


| **Task**              |  
|-----------------------|
| *id*                  |
| *user_id(FK)*         |
| name(string)          |
| content(text)         |
| priority(string)      |
| end_deadline(integer) |


| **Task_Label**  |  
|-----------------|
| *id*            |
| *task_id(FK)*   |
| *label_id(FK)*  |
|                 |


| **Label**       |  
|-----------------|
| *id*            |
| name(strings)   |


    
## Things you may want to cover:

* Ruby version: 2.6.5

* Rails version: 5.2.4

* Database: PostgreSQL 12.2