class AddUserIdCol < ActiveRecord::Migration
  def change
    add_reference :tracks, :user, foreign_key: true
  end
end
