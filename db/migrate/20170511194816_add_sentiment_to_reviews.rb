class AddSentimentToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :sentiment, :string
  end
end
