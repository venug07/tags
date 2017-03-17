class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :entity_id
      t.string :entity_type
      t.string  :name
      t.timestamps null: false
    end
  end
end
