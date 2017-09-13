class Substep < ApplicationRecord
  belongs_to :step
  belongs_to :item, polymorphic: true

  validates :step, :item, presence: true
end
