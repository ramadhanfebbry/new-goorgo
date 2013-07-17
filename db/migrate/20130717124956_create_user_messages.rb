class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.string :name
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
