class Ingredient < ApplicationRecord
  has_many :substeps, as: :item

  validates :name, presence: {unique: true}
end
