class CreateConversation < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
    

  t.integer :sender_id
  t.integer :recepient_id

  t.timestamps

  	end
  end


end