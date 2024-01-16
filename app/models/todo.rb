class Todo < ApplicationRecord
  has_many :todo_tags, dependent: :destroy

  belongs_to :user

  enum priority: %w[low medium high], _suffix: true
  enum recurrence: %w[none daily weekly monthly], _suffix: true

  has_many_attached :attachments, dependent: :destroy

  # validations

  # end for validations

  class << self
  end
end
