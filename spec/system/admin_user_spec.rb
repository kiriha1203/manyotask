require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    create(:user)
    create(:admin_user)
  end
  describe "管理画面のテスト" do
    context "管理者登録をしている場合" do
      before do
        visit login_path
      end
      it "管理者は管理画面にアクセスできること" do
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: '00000000'
        click_on 'ログインする'
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
      it "一般ユーザは管理画面にアクセスできないこと" do
        fill_in 'session_email', with: 'sample@example.com'
        fill_in 'session_password', with: '00000000'
        click_on 'ログインする'
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end
    end
    context "管理者登録をしている場合" do
      before do
        visit login_path
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: '00000000'
        click_on 'ログインする'
        visit admin_users_path
      end
      it "管理者はユーザを新規登録できること" do
        click_on "新規登録"
        fill_in "user_name", with: "admin2"
        fill_in "user_email", with: "admin2@example.com"
        check "user_admin"
        fill_in "user_password", with: '0000000'
        fill_in "user_password_confirmation", with: '0000000'
        click_on "登録する"
        expect(page).to have_content "admin2"
      end
      it "管理者はユーザの詳細画面にアクセスできること" do
        click_on "sample"
        expect(current_path).to eq admin_user_path(id: 3)
      end
      it "管理者はユーザの編集画面からユーザを編集できること" do
        click_on "sample"
        click_on "編集"
        fill_in "user_name", with: "change_admin"
        fill_in "user_email", with: "sample@example.com"
        check "user_admin"
        click_on "登録する"
        expect(page).to have_content "change_admin"
      end
      it "管理者はユーザの削除をできること" do
        click_link "削除", href: "/admin/users/3"
        page.accept_confirm
        visit admin_users_path
        expect(page).to have_no_content "sample"
      end
    end
  end
end