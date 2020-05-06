class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_secure_password

  before_destroy :cant_destroy_last_user_admin
  before_validation { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
  validates :password, presence: true, length: {minimum: 6}

  private

  def cant_destroy_last_user_admin
    #消す相手がadminかつDBの最後のadminの場合消せない
    user = User.find(id)
    if user.admin? && User.where(admin: true).count == 1
      throw :abort
    end
  end
end
