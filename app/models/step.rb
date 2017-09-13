class Step < ApplicationRecord
  belongs_to :recipe
  has_many :substeps

  validates :recipe, :action, presence: true
end
