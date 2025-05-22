class CreateHarvests < ActiveRecord::Migration[7.1]
  def change
    create_table :harvests do |t|
      t.date :date
      t.decimal :amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
