
require 'rails_helper'

RSpec.describe 'タスク検索機能', type: :system do
  before do
    user = create(:user)
    create(:task, name: "task", status: '未着手', user: user)
    create(:second_task, name: "sample", status: '着手中', user: user)
    create(:third_task, name: "aaa", status: '完了', user: user)
  end
  context '検索をした場合' do
    before do
      visit login_path
      fill_in 'session_email', with: 'sample@example.com'
      fill_in 'session_password', with: '00000000'
      click_on 'ログインする'
    end
    it "タイトルで検索できる" do
      visit tasks_path
      # タスクの検索欄に検索ワードを入力する (例: task)
      fill_in 'name_search', with: 'task'
      # 検索ボタンを押す
      click_on '検索'
      expect(page).to have_content 'task'
    end
    it "ステータスで検索できる" do
      visit tasks_path
      select '完了', from: 'status_search'
      click_on '検索'
      expect(page).to have_content '完了'
    end
    it "タイトルとステータスで検索できる" do
      visit tasks_path
      fill_in 'name_search', with: 'sam'
      select '着手中', from: 'status_search'
      click_on '検索'
      expect(page).to have_content '着手中'
      expect(page).to have_content 'sample'
    end
  end
end
