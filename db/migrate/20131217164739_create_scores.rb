class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :user_name
      t.integer :selected_team
      t.integer :score
      t.integer :conference_id

      t.timestamps
    end
  end
end
