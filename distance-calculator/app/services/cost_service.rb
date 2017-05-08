require "dijkstra"

class CostService
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :origin, :destiny, :weight, :distance, :path, :cost

  validates :origin, :destiny, :weight, presence: true

  COST_TAX = 0.15

  def initialize(origin, destiny, weight)
    @origin, @destiny, @weight = Location.find_by(name: origin), Location.find_by(name: destiny), weight.to_i
  end

  def cost_and_path
    load_path
    {
      path: @path,
      cost: @cost
    }
  end

  private

  def load_path
    distance_calc = Dijkstra.new(@origin.name, @destiny.name, courses)
    @cost = distance_calc.cost
    @path = distance_calc.shortest_path
  end

  def courses
    Course.all.map{ |course| [course.origin_location.name, course.destiny_location.name, cost_by_distance(course.distance)] }
  end

  def cost_by_distance(distance)
    distance * @weight * COST_TAX
  end
end