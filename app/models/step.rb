class Step < ApplicationRecord
  belongs_to :recipe
  has_many :components, -> { order('components.position') }, inverse_of: :step
  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true

  validates :recipe, :action, presence: true
  validates :position, uniqueness: {scope: :recipe}
end
