class Shelf < ApplicationRecord
    regex = /\A[a-fA-F0-9]{8}\-[a-fA-F0-9]{4}\-[a-fA-F0-9]{4}\-[a-fA-F0-9]{4}\-[a-fA-F0-9]{12}\z/
    validates :mainbeacon, presence: true, :format => {:with => regex}
    validates :beacon1, presence: true, :format => {:with => regex}
    validates :beacon2, presence: true, :format => {:with => regex}
    validates :beacon3, presence: true, :format => {:with => regex}
end
