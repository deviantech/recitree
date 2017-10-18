class Ingredient < ApplicationRecord
  has_many :components, as: :item
  has_many :steps, through: :components
  has_many :recipes, through: :steps

  default_scope -> { order("name") }

  validates :name, presence: true, uniqueness: {case_sensitive: true}
end
