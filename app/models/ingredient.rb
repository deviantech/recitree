class Ingredient < ApplicationRecord
  has_many :substeps, as: :item
end
