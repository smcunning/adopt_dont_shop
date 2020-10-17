class User < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def best_review
    best = reviews.order(rating: :desc).limit(1).first

    if best
    {
      title: best.title,
      rating: best.rating,
      content: best.content,
      image: best.image
    }
    else
      {
        title: "Nothing found.",
        rating: "Nothing found.",
        content: "Nothing found.",
      }
    end
  end

  def worst_review
    worst = reviews.order(:rating).limit(1).last
    if worst
    {
      title: worst.title,
      rating: worst.rating,
      content: worst.content,
      image: worst.image
    }
    end
  end
end
