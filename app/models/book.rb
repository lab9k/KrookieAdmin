class Book < ApplicationRecord
  self.primary_key = "isbn"
  belongs_to :shelf
end
