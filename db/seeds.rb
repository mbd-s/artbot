#sample query strings to build db

# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Johannes+Vermeer&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Vincent+van+Gogh&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Rembrandt+Harmensz.+van+Rijn&type=painting&imgonly=True'
# single object by objectNumber 'https://www.rijksmuseum.nl/api/en/collection/SK-C-251?' + 'key=ENV['RIJKMUSEUM_API_TOKEN']' + '&format=json'
Art.destroy_all
Artist.destroy_all
puts "All old art & artists have been cleared."

# art lists
vermeer_art = [
  {title: 'Woman Reading a Letter', image: 'http://lh3.ggpht.com/_hNgP8xlzkSVD_XfBIy3j6BSWyGqdc0N921xFJbXG7jwFbQ7hi8IuTO6AIAsQf_RI3_dt4_EEncuuLY5pVO0vT50qpY=s0', object_number: 'SK-C-251', year: '1663', century: '17th', medium: 'painting'},
  {title: 'The Milkmaid', image: 'http://lh3.ggpht.com/XUw3NdeiA0MsT-mygp8NT1oPUd17GB3BK2nSRYvyTAY-N64KwsLOO5QU3muSDEk2AdMzonIVLgjge581mOobVqsQrA=s0', object_number: 'SK-A-2344', year: '1660', century: '17th', medium: 'painting'},
  {title: 'The Love Letter', image: 'http://lh4.ggpht.com/cIUsjrkQbRd5BMh9nv7nxib8lKisKC0CEmUdJTFvRkcqaT65EyLwQH8fBnBSY8tAnprq4VzGfIQ1sVbp6h0vAWWf4vEW=s0', object_number: 'SK-A-1595', year: '1669', century: '17th', medium: 'painting'}
]
van_gogh_art = [
  {title: 'Self-portrait', image: 'http://lh4.ggpht.com/RKAJ3z2mOcw83Ju0a7NIp71oUoJbVWJQzxwki5PSERissvWIrELCuxxGZ12U0PeAnf6WLkRCzpFdvjweUBjlcr2I4dl_=s0', object_number: 'SK-A-3262', year: '1887', century: '19th', medium: 'painting'}
]
rembrandt_art = [
  {title: "Militia Company of District II under the Command of Captain Frans Banninck Cocq, Known as the 'Night Watch'", image: 'http://lh6.ggpht.com/ZYWwML8mVFonXzbmg2rQBulNuCSr3rAaf5ppNcUc2Id8qXqudDL1NSYxaqjEXyDLSbeNFzOHRu0H7rbIws0Js4d7s_M=s0', object_number: 'SK-C-5', year: '1642', century: '17th', medium: 'painting'}
]

# artists
vermeer = {name: "Johannes Vermeer", birth: "1632", death: "1675", nationality: "Dutch"}
van_gogh = {name: "Vincent van Gogh", birth: "1853", death: "1890", nationality: "Dutch"}
rembrandt = {name: "Rembrandt Harmensz. van Rijn", birth: "1606", death: "1669", nationality: "Dutch"}

# art/artist creator/associator
def add_art(artist, art_list)
  a = Artist.create(artist)
  art_list.each do |art|
    painting = Art.create(art)
    a.arts << painting
  end
end

# -------MAIN------- #

add_art(vermeer, vermeer_art)
add_art(van_gogh, van_gogh_art)
add_art(rembrandt, rembrandt_art)
puts "Created #{Artist.count} artists, and #{Art.count} paintings."
