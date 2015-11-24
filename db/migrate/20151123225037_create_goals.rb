class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :goal_title, null: false
      t.boolean :hidden, null: false
      t.integer :completion, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
