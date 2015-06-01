class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :name
      t.integer :number_of_team
      t.integer :max_score
      t.integer :user_id

      t.timestamps
    end
  end
end
