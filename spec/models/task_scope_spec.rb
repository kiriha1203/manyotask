require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(name: "task", content: "sample_task", end_deadline: '2030-05-30', priority: "低", status: "未着手")
      Task.create(name: "sample", content: "sample_sample", end_deadline: '2030-05-30', priority: "低", status: "未着手")
      Task.create(name: "sample2", content: "sample_sample2", end_deadline: '2030-05-30', priority: "高", status: "完了")
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