class Course < ApplicationRecord
  validates :distance, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100_000 }
  validates_associated :origin_location
  validates_associated :destiny_location
  validates :origin_location, :destiny_location, presence: true
  validate :uniq_destiny_and_location

  belongs_to :origin_location, :class_name => "Location", :foreign_key => "origin_location_id"
  belongs_to :destiny_location, :class_name => "Location", :foreign_key => "destiny_location_id"

  private

  def uniq_destiny_and_location
    if course_exists?
      errors.add(:base, :course_exists)
    end
  end

  def course_exists?
    Course.find_by(origin_location_id: origin_location_id, destiny_location_id: destiny_location_id).present? || Course.find_by(origin_location_id: destiny_location_id, destiny_location_id: origin_location_id).present?
  end
end
