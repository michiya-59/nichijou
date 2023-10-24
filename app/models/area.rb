# frozen_string_literal: true

class Area < ApplicationRecord
  validates :name, presence: true
end
