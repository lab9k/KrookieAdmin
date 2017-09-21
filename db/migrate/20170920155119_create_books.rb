class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :ISBN
      t.string :title
      t.string :author
      t.string :fact
      t.integer :readingskill
      t.string :category
      t.integer :shelf

      t.timestamps
    end
  end
end
