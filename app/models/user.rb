class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :applications

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
    else
    {
      title: "Nothing found.",
      rating: "Nothing found.",
      content: "Nothing found.",
    }
    end
  end

  def average_review
    average = (reviews.sum(:rating) / reviews.count(:rating).to_f).round(2)
  end
end
