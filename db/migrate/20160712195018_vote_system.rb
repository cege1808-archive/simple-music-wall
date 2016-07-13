class VoteSystem < ActiveRecord::Migration
  def change

    create_table :votes do |t|
      t.timestamps null: false
    end

    add_reference :votes, :user, foreign_key: true
    add_reference :votes, :track, foreign_key: true
    
  end
end
