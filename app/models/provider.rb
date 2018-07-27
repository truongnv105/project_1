# frozen_string_literal: true

class Provider < ApplicationRecord
  validates :provider, uniqueness: { scope: :uid }
  belongs_to :user
end
