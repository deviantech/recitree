class RenameSubstepsToComponents < ActiveRecord::Migration[5.1]
  def change
    rename_table :substeps, :components
  end
end
