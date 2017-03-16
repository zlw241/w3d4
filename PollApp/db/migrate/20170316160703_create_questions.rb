class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :question, :null => false
      t.integer :poll_id, :null => false
      
      t.timestamps
    end
  end
end
