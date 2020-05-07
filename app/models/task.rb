class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  validates :name, presence: true
  validates :content, presence: true
  validate :date_not_pretend_ago
  validates :priority, presence: true
  validates :status, presence: true

  def date_not_pretend_ago
    errors.add(:end_deadline,"は今日以降のものを選択してください") if end_deadline.nil? || end_deadline < Date.today
  end

  scope :recent, -> { order(id: :desc)}
  scope :name_like, -> (name_search) do
    next if name_search.blank?
    where("tasks.name LIKE ?", "%#{name_search}%")
  end

  scope :status_search, -> (status_search) do
    next if status_search.blank?
    where(status: status_search)
  end

  scope :label_search, -> (label_search) do
    next if label_search.blank?
    joins(:labels).where(labels: { id: label_search})
  end

  enum priority: { 高: 0, 中: 50, 低: 99 }
  enum status:  { 未着手: 0, 着手中: 1, 完了: 99}
end
