class AddAdoptableToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :adoptable, :boolean
  end
end
