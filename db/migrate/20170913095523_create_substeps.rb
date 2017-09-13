class CreateSubsteps < ActiveRecord::Migration[5.1]
  def change
    create_table :substeps do |t|
      t.belongs_to :step, foreign_key: true
      t.float :quantity, default: 1
      t.string :unit
      t.string :item_type
      t.integer :item_id

      t.timestamps
    end
  end
end
