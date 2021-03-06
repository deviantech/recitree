class Component < ApplicationRecord
  belongs_to :step, inverse_of: :components
  belongs_to :item, polymorphic: true

  VALID_TYPES = %w(Step Ingredient)

  # validates :item, presence: true
  # validates :position, uniqueness: {scope: :step}

  UNITS = %w(cups teaspoons tablespoons grams ounces mL stalk clove package)

end
