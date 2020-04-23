class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validate :date_not_pretend_ago

  def date_not_pretend_ago
    errors.add(:end_deadline,"は今日以降のものを選択してください") if end_deadline.nil? || end_deadline < Date.today
  end

  scope :recent, -> { order(id: :desc)}
end
