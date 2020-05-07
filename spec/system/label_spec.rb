require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system do
  before do
    create(:user)
    create(:admin_user)
    create(:label)
  end
  describe "ラベルのテスト" do
    context "管理者登録をしている場合" do
      before do
        visit login_path
      end
      it "一般ユーザはラベル一覧にアクセスできないこと" do
        fill_in 'session_email', with: 'sample@example.com'
        fill_in 'session_password', with: '00000000'
        click_on 'ログインする'
        visit admin_labels_path
        expect(current_path).to eq tasks_path
      end
    end
    context "管理者登録をしている場合" do
      before do
        visit login_path
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: '00000000'
        click_on 'ログインする'
        visit admin_labels_path
      end
      it "管理者はラベルを新規登録できること" do
        click_on "新規登録"
        fill_in 'label_name', with: 'python'
        click_on '登録する'
        visit admin_labels_path
        expect(Label.count).to eq 2
      end
      it "管理者はラベルの編集画面からユーザを編集できること" do
        click_on "編集"
        fill_in "label_name", with: "change_label"
        click_on "更新する"
        expect(page).to have_content "change_label"
      end
      it "管理者はラベルの削除をできること" do
        click_link "削除", href: "/admin/labels/3"
        page.accept_confirm
        visit admin_labels_path
        expect(page).to have_no_content "ruby"
      end
    end
  end
end
