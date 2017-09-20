class Shelf < ApplicationRecord
    validates :mainbeacon, presence: true
    validates :beacon1, presence: true
    validates :beacon2, presence: true
    validates :beacon3, presence: true
end
