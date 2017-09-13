class Step < ApplicationRecord
  belongs_to :recipe
  has_many :substeps
  belongs_to :item, polymorphic: true
end
