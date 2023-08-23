# frozen_string_literal: true

# Hero model
class Hero < ApplicationRecord
  validates :name, :token, presence: true

  scope :by_token, ->(token) { where(token: token) }
  scope :sorted_by_name, -> { order(:name) }
  scope :search, ->(term) { where('LOWER(name) LIKE ?', "%#{term.downcase}%") if term.present? }
end
