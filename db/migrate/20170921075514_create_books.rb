class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :category
      t.integer :readingskill
      t.string :fact
      t.references :shelf, foreign_key: true

      t.timestamps
    end
  end
end
