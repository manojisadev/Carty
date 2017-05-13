class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
    	t.float :total
    	t.boolean :active
      t.timestamps
    end
  end
end
