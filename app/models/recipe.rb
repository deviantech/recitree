class Recipe < ApplicationRecord
  has_many :steps, -> { order('steps.order') }, dependent: :destroy
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
