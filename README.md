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

## Heroku deploy 

* [Heroku app URL](https://enigmatic-dawn-55684.herokuapp.com/)

1. 作業したブランチからmasterブランチへプルリクエスト、マージを行う。

2. masterブランチを最新の情報へ更新する。
    ```Bash:title
     $ git pull origin master
    ```
3. アセットプリコンパイルを実行し、本番環境で利用するためのアセットファイルを生成する。
     ```Bash:title
     $ rails assets:precompile RAILS_ENV=production
     ```

4. Herokuに新しいアプリケーションを作成する。
    ```Bash:title
     $ heroku create
    ```

5. npmを使用できるために'buildpacks'を追加する。
    ```Bash:title
    $ heroku buildpacks:set heroku/nodejs

    $ heroku buildpacks:add --index 2 heroku/ruby
    ```

6. Herokuにデプロイする。
    ```Bash:title
    $ git add -A
 
    $ git commit -m "内容"

    $ git push heroku master
    ```

7. Herokuデーターベースのマイグレーションを行う。
    ```Bash:title
    $ heroku run rails db:migrate
    ```

8. HerokuとGithubを連携させる。  
    1. [ここ](https://dashboard.heroku.com)にてGitHubと連携させたいアプリを選択。
    2. [Deploy]タブを選択。
    3. [Deployment method]セクションで[GitHub]を選択し、[Connect to GitHub]セクションの[Connect to GitHub]をクリックします。
    4. [Connect to GitHub]で連携するリポジトリを検索・選択して [Connect]をクリックします。
    5. [Automatic deploys]セクションでデプロイするブランチを選択して [Enable Automatic Deploys]をクリックします。
    6. Herokuのビルドが自動的に実行されます。
 
 

