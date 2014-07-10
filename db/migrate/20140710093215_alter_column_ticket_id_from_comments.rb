class AlterColumnTicketIdFromComments < ActiveRecord::Migration
  def change
    add_column :comments, :ticket_id, :integer
  end
  
  remove_column :comments, :tiecket_id
end
