class CreateShelves < ActiveRecord::Migration[5.1]
  def change
    create_table :shelves do |t|
      t.string :mainbeacon
      t.string :beacon1
      t.string :beacon2
      t.string :beacon3

      t.timestamps
    end
  end
end
