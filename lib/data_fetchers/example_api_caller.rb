# class ExampleApi
#
#   attr_reader :url, :music_data
#
#   def initialize(url)
#     @url = url
#     @music_data = JSON.parse(RestClient.get("https://data.cityofnewyork.us/resource/yes4-7zbb.json?neighborhoodname=Crown%20Heights"))
#     binding.pry
#   end
#
#   def make_albums
#     albums = []
#     all_albums = music_data["tracks"]["items"]
#     binding.pry
#     all_albums.each do |album|
#       album_name = album["name"]
#       albums << ExampleModel.new(album_name)
#     end
#     albums
#   end
#
# end

#ExampleApi.new("https://data.cityofnewyork.us/resource/yes4-7zbb.json?neighborhoodname=Crown%20Heights")
class ExampleApi
  attr_accessor :url, :gardens

  def initialize(url)
    @url = url
    @gardens = JSON.parse(RestClient.get(url))
    binding.pry
  end

  def make_object_add_to_array(hash)
    binding.pry
    community_gardens = []

  end
end
