class Book < ApplicationRecord
  validates :isbn, uniqueness: true
  self.primary_key = "isbn"
  belongs_to :shelf
end
