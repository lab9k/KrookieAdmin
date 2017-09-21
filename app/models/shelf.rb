class Shelf < ApplicationRecord
    has_many :books
    validates :mainbeacon, presence: true
    validates :beacon1, presence: true
    validates :beacon2, presence: true
    validates :beacon3, presence: true
end
