class CreateFavoriteProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_products do |t|
      t.references :user, foreign_key: true
      t.refereces :product

      t.timestamps
    end
  end
end
