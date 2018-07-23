class Contact < ApplicationRecord
  belongs_to :user
  has_many :addresses, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
end
