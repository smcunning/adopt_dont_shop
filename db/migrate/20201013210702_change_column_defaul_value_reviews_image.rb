class ChangeColumnDefaulValueReviewsImage < ActiveRecord::Migration[5.2]
  def change
    change_column_default :reviews, :image, "https://www.google.com/imgres?imgurl=https%3A%2F%2Fpreviews.123rf.com%2Fimages%2Fpredragilievski%2Fpredragilievski1609%2Fpredragilievski160900001%2F66526873-llama-silhouette.jpg&imgrefurl=https%3A%2F%2Fwww.123rf.com%2Fphoto_66526873_stock-vector-llama-silhouette.html&tbnid=mOZ-b2RTnSce_M&vet=12ahUKEwi0kt6HvbLsAhWMO80KHTnXAYIQMygDegUIARC7Ag..i&docid=KFEvLGD3lIbyDM&w=1145&h=1300&q=silhouette%20llama&ved=2ahUKEwi0kt6HvbLsAhWMO80KHTnXAYIQMygDegUIARC7Ag"
  end
end
