require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    user = create(:user)
    create(:task, user: user)
    create(:second_task, user: user)
    create(:third_task, user: user)
    visit login_path
    fill_in 'session_email', with: 'sample@example.com'
    fill_in 'session_password', with: '00000000'
    click_on 'ログインする'
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        # タスク一覧ページに遷移
        visit tasks_path
        # 遷移したページに「Factoryで作ったデフォルトのタイトル１」という文字列が含まれているか
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        # タスク一覧ページに遷移
        visit tasks_path
        task_list = all('tbody tr') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル３'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context '終了期限でソートする' do
      it '終了期限の降順で並んでいる' do
        # タスク一覧ページに遷移
        wait = Selenium::WebDriver::Wait.new(:timeout => 100)
        visit tasks_path
        click_on 'desc_end_deadline'
        task_list = all('tbody tr')
        wait.until{expect(task_list[0]).to have_content '2030-05-30'}
        wait.until{expect(task_list[1]).to have_content '2030-04-30'}
        wait.until{expect(task_list[2]).to have_content '2030-03-30'}
      end
    end
    context '優先順位でソートする' do
      it '優先順位の昇順で並んでいる' do
        # タスク一覧ページに遷移
        wait = Selenium::WebDriver::Wait.new(:timeout => 100)
        visit tasks_path
        click_on 'asc_priority'
        task_list = all('tbody tr')
        wait.until{expect(task_list[0]).to have_content '高'}
        wait.until{expect(task_list[1]).to have_content '中'}
        wait.until{expect(task_list[2]).to have_content '低'}
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        # new_task_pathにvisitする（タスク登録ページに遷移する)
        # 1.ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
        # タスクのタイトルと内容をそれぞれfill_in（入力）する
        # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task_name', with: 'task2'
        # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task_content', with: 'rspec_test2'
        fill_in "task_end_deadline", with: Date.today
        select '完了', from: 'task_status'
        select '低', from: 'task_priority'
        # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
        # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on '登録する'
        # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'タスク「task2」を登録しました'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        #indexに遷移する
        visit tasks_path
        #任意のタスクの詳細画面に遷移する。
        click_on 'Factoryで作ったデフォルトのタイトル１'
        #タスクの詳細ページにcontentの内容が含まれているか。
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
      end
    end
  end
end