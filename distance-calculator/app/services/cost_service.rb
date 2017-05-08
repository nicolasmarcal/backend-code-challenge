require "dijkstra"

class CostService
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :origin, :destiny, :weight, :distance, :path

  validates :origin, :destiny, :weight, :distance, :path, presence: true

  COST_TAX = 0.15

  def initialize(origin, destiny, weight)
    @origin, @destiny = origin, destiny
    load_path
  end

  def cost_and_path
    {
      path: @path,
      cost: cost
    }
  end

  private

  def cost
    @distance * @weight * COST_TAX
  end

  def load_path
    distance_calc = Dijkstra.new(@origin, @destination, courses)
    @distance = distance_calc.cost.to_i
    @path = distance_calc.shortest_path
  end

  def courses
    Course.all.map{ |course| [course.origin_location.name, course.destiny_location.name, course.distance] }
  end
end