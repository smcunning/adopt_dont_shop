class ChangeColumnDefaultValueReviewsImage < ActiveRecord::Migration[5.2]
  def change
    change_column_default :reviews, :image, "https://i.ibb.co/F7HmJfk/llama.jpg"
  end
end
