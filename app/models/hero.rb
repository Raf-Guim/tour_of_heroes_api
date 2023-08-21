# frozen_string_literal: true

# Hero model
class Hero < ApplicationRecord
  validates :name, presence: true
end
