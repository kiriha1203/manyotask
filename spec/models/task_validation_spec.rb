require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', content: '失敗テスト', end_deadline: '2030-05-30', priority: "高", status: "完了")
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '', end_deadline: '2030-05-30', priority: "高", status: "完了")
    expect(task).not_to be_valid
  end
  it 'title,content,end_deadline,status,priorityに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '成功テスト', content: '成功テスト', end_deadline: '2030-05-30', priority: "高", status: "完了")
    expect(task).to be_valid
  end
end