require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    create(:user)
  end
  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', content: '失敗テスト', end_deadline: '2030-05-30', priority: "高", status: "完了", user_id: 3)
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '', end_deadline: '2030-05-30', priority: "高", status: "完了", user_id: 3)
    expect(task).not_to be_valid
  end
  it 'end_deadlineが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '失敗テスト', end_deadline: '', priority: "高", status: "完了", user_id: 3)
    expect(task).not_to be_valid
  end
  it 'priorityが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '失敗テスト', end_deadline: '2030-05-30', priority: "", status: "完了", user_id: 3)
    expect(task).not_to be_valid
  end
  it 'statusが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '失敗テスト', end_deadline: '2030-05-30', priority: "高", status: "", user_id: 3)
    expect(task).not_to be_valid
  end
  it 'title,content,end_deadline,status,priorityに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '成功テスト', content: '成功テスト', end_deadline: '2030-05-30', priority: "高", status: "完了", user_id: 3)
    expect(task).to be_valid
  end
end