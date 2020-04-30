
require 'rails_helper'

RSpec.describe 'タスク検索機能', type: :system do
  context '検索をした場合' do
    before do
    FactoryBot.create(:task, name: "task", status: '未着手')
    FactoryBot.create(:second_task, name: "sample", status: '着手中')
    FactoryBot.create(:third_task, name: "aaa", status: '完了')
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
