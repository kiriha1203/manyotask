require 'rails_helper'

RSpec.describe 'ユーザー登録機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    user = User.new(name: '', email: 'sample@example.com', password: '00000000')
    expect(user).not_to be_valid
  end
  it 'emailが空ならバリデーションが通らない' do
    user = User.new(name: 'sample', email: '', password: '00000000')
    expect(user).not_to be_valid
  end
  it 'emailが既に登録済みの場合、バリデーションが通らない' do
    create(:user)
    user = User.new(name: "sample2", email: "sample@example.com", password: "0000000")
    expect(user).not_to be_valid
  end
  it 'emailの書式出ない場合、バリデーションが通らない' do
    user = User.new(name: "sample", email: "aaaaaaa", password: "0000000")
    expect(user).not_to be_valid
  end
  it 'passwordが空ならバリデーションが通らない' do
    user = User.new(name: "sample", email: "sample@example.com", password: "")
    expect(user).not_to be_valid
  end
  it 'passwordが6文字未満ならバリデーションが通らない' do
    user = User.new(name: "sample", email: "sample@example.com", password: "00000")
    expect(user).not_to be_valid
  end
  it 'name,email,passwordの内容が記載されていればバリデーションが通る' do
    user = User.new(name: "sample", email: "sample@example.com", password: "0000000")
    expect(user).to be_valid
  end
end