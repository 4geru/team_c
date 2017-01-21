class CreateKeeps < ActiveRecord::Migration[5.0]
  def change
  	create_table :keeps do |t|
  		t.string :channel
  		t.string :json
  		t.timestamps null: false
  		
  		t.index [:channel, :json], :unique => true
  	end
  end
end
