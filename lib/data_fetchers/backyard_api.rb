 require 'json'
# require 'pry'

class GetCommunityGardensAPI
  attr_accessor :url, :gardens, :community_gardens

  def initialize(url)
    @url = url
    @gardens = JSON.parse(RestClient.get(url))
    @community_gardens = []
  end

  def make_object_add_to_array
      @gardens.each {|garden|
      name = garden["garden_name"]
      address = garden["address"]
      borough = garden["boro"]
      cross_streets = garden["cross_streets"]
      @community_gardens << make_garden(name, address, borough, cross_streets)
    }
  end

  def make_garden (name, address, borough, cross_streets)
    Garden.new(name, address, borough, cross_streets)
  end
end
