class AddDefaultTrueAdoptableForPets < ActiveRecord::Migration[5.2]
  def change
    change_column_default :pets, :adoptable, true
  end
end
