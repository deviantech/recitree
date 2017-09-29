class Step < ApplicationRecord
  belongs_to :recipe
  has_many :components, -> { order('components.order') }, inverse_of: :step
  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true

  validates :recipe, :action, presence: true
  validates :order, uniqueness: {scope: :recipe}
end
