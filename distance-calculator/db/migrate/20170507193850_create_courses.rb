class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.integer :origin_location_id
      t.integer :destiny_location_id
      t.integer :distance

      t.timestamps
    end
  end
end
