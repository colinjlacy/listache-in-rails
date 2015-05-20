class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
		t.string :title
		t.text :list_items

		t.timestamps null: false
    end
  end
end
