require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  context 'scopeメソッドで検索をした場合' do
    before do
      user = create(:user)
      create(:task, name: "task", user: user)
      create(:second_task, name: "sample", user: user)
      create(:third_task, name: "sample2", user: user)

    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.name_like('task').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.status_search('完了').count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.name_like('sample').status_search('未着手').count).to eq 1
    end
  end
end