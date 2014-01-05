class CreateKeyConcepts < ActiveRecord::Migration
  def change
    create_table :key_concepts do |t|
      t.string :info
      t.references :lesson
      t.integer :ratingCount
      t.float :ratingAverage
      t.timestamps
    end
  end
end
