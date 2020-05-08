require 'rails_helper'
RSpec.describe  "ラベル登録機能" do
  it "titleが既に登録済みの場合、バリデーションが通らない" do
    create(:label)
    label = Label.new(name: "ruby" )
    expect(label).not_to be_valid
  end
end