class CreateCarSpiders < ActiveRecord::Migration[6.0]
  def change
    create_table :car_spiders do |t|

      t.timestamps
    end
  end
end
