class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.boolean :like
      t.string :comment

      t.timestamps
    end
  end
end
