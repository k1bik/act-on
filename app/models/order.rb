# typed: strict

class Order < ApplicationRecord
  STATUSES = T.let([
    CREATED = "created",
    IN_PROGRESS = "in_progress",
    AWAITING_PICKUP = "awaiting_pickup",
    COMPLETED = "completed"
  ].freeze, T::Array[String])

  enum :status, STATUSES.index_with(&:itself), default: CREATED

  belongs_to :location

  validates :due_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
end
