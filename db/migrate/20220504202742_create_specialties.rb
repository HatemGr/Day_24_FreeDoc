class CreateSpecialties < ActiveRecord::Migration[5.2]
  def change
    create_table :specialties do |t|
      t.string :speciality_name

      t.timestamps
    end
  end
end
