class Task < ApplicationRecord
  scope :recent, -> { order(id: :desc)}
end
