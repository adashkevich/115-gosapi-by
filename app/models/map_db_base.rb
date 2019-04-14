class MapDbBase < ApplicationRecord

  self.abstract_class = true
  establish_connection MAP_GOASPI_DB
end