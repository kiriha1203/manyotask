# README

## Database

| *User*          |  
|-----------------|
| id              |
|-----------------|
| name            |
| email           |
| password_digest |


| *Task*          |  
|-----------------|
| id              |
| user_id(FK)     |
|-----------------|
| name            |
| content         |
| priority        |
| end_deadline    |


| *Task_Label*    |  
|-----------------|
| id              |
| task_id(FK)     |
| label_id(FK)    |
|-----------------|
|                 |


| *Label*         |  
|-----------------|
| id              |
|-----------------|
| name            |


    
## Things you may want to cover:

* Ruby version: 2.6.5

* Rails version: 5.2.4

* Database: PostgreSQL 12.2