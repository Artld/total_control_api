class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer :reward
      t.string :state, default: 'open'
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
