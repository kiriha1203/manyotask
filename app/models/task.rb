class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :content, presence: true
  validate :date_not_pretend_ago
  validates :priority, presence: true
  validates :status, presence: true

  def date_not_pretend_ago
    errors.add(:end_deadline,"は今日以降のものを選択してください") if end_deadline.nil? || end_deadline < Date.today
  end

  scope :recent, -> { order(id: :desc)}
  scope :name_like, -> (name_search) { where('name LIKE ?', "%#{name_search}%")}
  scope :status_search, ->(status_search) { where( status: status_search)}


  enum priority: { 高: 0, 中: 50, 低: 99 }
  enum status:  { 未着手: 0, 着手中: 1, 完了: 99}
end
