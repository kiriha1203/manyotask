class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  scope :recent, -> { order(id: :desc)}
end
