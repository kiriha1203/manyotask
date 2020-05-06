require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :model do
  context "管理者が一人の場合" do
    it "管理者ユーザーは削除できない。" do
      user = create(:admin_user)
      user.destroy
      expect(user.name).to eq 'admin'
    end
    it "管理者ユーザーは削除できない（メソッドが呼び出しているか）" do
      user = create(:admin_user)
      allow(user).to receive(:cant_destroy_last_user_admin)
      user.destroy
      expect(user).to have_received(:cant_destroy_last_user_admin)
    end
  end
end