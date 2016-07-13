class ReviewSystem < ActiveRecord::Migration
  def change

    create_table :reviews do |t|
      t.string :comment
      t.integer :rating
      t.timestamps null: false
    end

    add_reference :reviews, :user, foreign_key: true
    add_reference :reviews, :track, foreign_key: true

  end
end
