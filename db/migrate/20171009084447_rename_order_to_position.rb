class RenameOrderToPosition < ActiveRecord::Migration[5.1]
  def change
    rename_column :components, :order, :position
    rename_column :steps, :order, :position
  end
end
