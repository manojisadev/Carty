class ChangeColumnNameFromCommetToComment < ActiveRecord::Migration[5.0]
  def change
  	rename_column :reviews, :commet, :comment
  end
end
