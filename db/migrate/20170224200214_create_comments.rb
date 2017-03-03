class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :comment, foreign_key: true

      t.timestamps
    end
    change_table :comments do |t|
      t.rename :comment_id, :origin_id
    end
  end
end
