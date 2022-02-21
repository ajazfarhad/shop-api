class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.float :rate
      t.string :message
      t.string :name
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
