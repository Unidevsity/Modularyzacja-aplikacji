class CreateBookReadModels < ActiveRecord::Migration[7.0]
  def change
    create_table :book_read_models do |t|
      t.references :book, null: false, foreign_key: true
      t.string :title
      t.string :author_name
      t.string :author_id
      t.text :reservations
      t.text :borrow_histories

      t.timestamps
    end
  end
end
