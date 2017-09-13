class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.belongs_to :recipe, foreign_key: true
      t.integer :order
      t.integer :duration, default: 0
      t.string :duration_unit
      t.string :action
      t.string :notes
      t.boolean :has_next_action, default: false

      t.timestamps
    end
  end
end
