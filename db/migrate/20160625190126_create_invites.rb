class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
    	t.integer :invitee_id
    	t.integer :inviter_id

      t.timestamps null: false
    end
  end
end
