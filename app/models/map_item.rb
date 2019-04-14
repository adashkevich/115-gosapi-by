class MapItem < MapDbBase

  self.table_name = 'items'

  attr_accessor :lat
  attr_accessor :lng

  def coordinates
    "#{@lat},#{@lng}"
  end

  before_save do
    write_attribute(:coordinates, coordinates)
  end
end
