class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :owner_id, null: false
      t.string :title, null: false
      t.text :description
      t.boolean :private, default: false
      t.boolean :completed, default: false

      t.timestamps
    end

    add_index :goals, :owner_id
    add_index :goals, :title
  end
end
