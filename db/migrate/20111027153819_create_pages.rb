class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :body
      t.integer :parent_id
      t.integer :position

      t.timestamps
    end
  end
end
