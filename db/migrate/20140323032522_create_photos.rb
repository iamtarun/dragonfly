class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image_uid
      t.string :image_name

      t.timestamps
    end
  end
end
