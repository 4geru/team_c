class CreateKeeps < ActiveRecord::Migration[5.0]
  def change
  	create_table :keeps do |t|
  		t.string :channel
  		t.string :json
  		t.timestamps null: false
  	end
#  	add_index  :keywords, , [:site_id, :name, :date], unique: true
  end
end
