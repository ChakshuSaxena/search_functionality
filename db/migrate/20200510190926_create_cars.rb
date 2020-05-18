class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :title
      t.string :stock_type
      t.string :exterior_color
      t.string :interior_color
      t.string :transmission
      t.string :drivetrain
      t.integer :price
      t.integer :miles

      t.timestamps
    end
  end
end
