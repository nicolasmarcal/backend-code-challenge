class Location < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :destiny_course, :class_name => "Route", :foreign_key => "origin_location_id"
  has_many :origin_course, :class_name => "Route", :foreign_key => "destiny_location_id"
end
