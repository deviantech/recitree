class Ingredient < ApplicationRecord
  has_many :components, as: :item
  has_many :steps, through: :components
  has_many :recipes, through: :steps

  validates :name, presence: {unique: true}
end
