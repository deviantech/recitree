class AddOrderToSubsteps < ActiveRecord::Migration[5.1]
  def change
    add_column :substeps, :order, :integer
  end
end
