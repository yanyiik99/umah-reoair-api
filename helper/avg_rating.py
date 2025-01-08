"""Average Rating Helpers"""

def avg_rating(ratings):
  return sum(ratings) / len(ratings) if ratings else None