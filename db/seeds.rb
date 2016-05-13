
require 'http'
require 'json'

params = {:key => "#{ENV['RIJKMUSEUM_API_TOKEN']}", :format => 'json', :maker => 'Vincent van Gogh', :type => 'painting.png', :imgonly => 'True'}
base_endpoint = "https://www.rijksmuseum.nl/api/en/collection"

rc = HTTP.get(base_endpoint, params: params)
puts rc
a = JSON.parse(rc.body)
puts a

#query strings to build db


# '&format=json&maker=Johannes+Vermeer&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Vincent+van+Gogh&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Rembrandt+Harmensz.+van+Rijn&type=painting&imgonly=True'


art_list = [
  {:title => 'Title1', :artist => 'Artist1', :image => 'img1.png',  :year => '1662',  :century => 'Sixteenth',  :medium => 'Mixed media'},
  {:title => 'Title2', :artist => 'Artist2', :image => 'img2.png',  :year => '1777',  :century => 'Sixteenth',  :medium => 'Some media'},
  {:title => 'Title3', :artist => 'Artist3', :image => 'img3.png',:year => '1888', :century => 'Eighteenth', :medium => 'Other media'}
  ]


# ----------MAIN---------- #
Art.destroy_all

art_list.each do |art|
  Art.create(art)
  p "made an art!"
end
