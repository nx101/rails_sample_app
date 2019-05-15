class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end

    # add indices to pull microposts by user_id and creation time
    add_index :microposts, [:user_id, :created_at]

  end
end
