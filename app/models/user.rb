class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_secure_password

  before_destroy :cant_destroy_last_user_admin
  before_update :cant_update_last_user_admin

  before_validation { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}

  private

  def cant_destroy_last_user_admin
    #消す相手がadminかつDBの最後のadminの場合消せない
    if admin? && User.where(admin: true).count <= 1
      errors.add(:base, '少なくとも一人の管理者が必要です。')
      throw :abort
    end
  end

  def cant_update_last_user_admin
    if admin_was && User.where(admin: true).count <= 1 && admin == false
      errors.add(:base, '少なくとも一人の管理者が必要です。')
      throw :abort
    end
  end
end
