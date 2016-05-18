#sample query strings to build db

# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Johannes+Vermeer&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Vincent+van+Gogh&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Rembrandt+Harmensz.+van+Rijn&type=painting&imgonly=True'
# single object by objectNumber 'https://www.rijksmuseum.nl/api/en/collection/SK-C-251?' + 'key=ENV['RIJKMUSEUM_API_TOKEN']' + '&format=json'
Art.destroy_all
Artist.destroy_all
puts "All old artworks and artists have been cleared."

# art lists
#new_art_list = []
vermeer_art = [
  {title: 'Woman Reading a Letter', image: 'http://lh3.ggpht.com/_hNgP8xlzkSVD_XfBIy3j6BSWyGqdc0N921xFJbXG7jwFbQ7hi8IuTO6AIAsQf_RI3_dt4_EEncuuLY5pVO0vT50qpY=s0', year: '1663', century: '17th', medium: 'painting'},
  {title: 'The Milkmaid', image: 'http://lh3.ggpht.com/XUw3NdeiA0MsT-mygp8NT1oPUd17GB3BK2nSRYvyTAY-N64KwsLOO5QU3muSDEk2AdMzonIVLgjge581mOobVqsQrA=s0', year: '1660', century: '17th', medium: 'painting'},
  {title: 'The Love Letter', image: 'http://lh4.ggpht.com/cIUsjrkQbRd5BMh9nv7nxib8lKisKC0CEmUdJTFvRkcqaT65EyLwQH8fBnBSY8tAnprq4VzGfIQ1sVbp6h0vAWWf4vEW=s0', year: '1669', century: '17th', medium: 'painting'}
]
van_gogh_art = [
  {title: 'Self-portrait', image: 'http://lh4.ggpht.com/RKAJ3z2mOcw83Ju0a7NIp71oUoJbVWJQzxwki5PSERissvWIrELCuxxGZ12U0PeAnf6WLkRCzpFdvjweUBjlcr2I4dl_=s0', year: '1887', century: '19th', medium: 'painting'}
]
rembrandt_art = [
  {title: "Militia Company of District II under the Command of Captain Frans Banninck Cocq, Known as the 'Night Watch'", image: 'http://lh6.ggpht.com/ZYWwML8mVFonXzbmg2rQBulNuCSr3rAaf5ppNcUc2Id8qXqudDL1NSYxaqjEXyDLSbeNFzOHRu0H7rbIws0Js4d7s_M=s0', year: '1642', century: '17th', medium: 'painting'}
]

matisse_art = [{title: "Dance (I)", image: "https://upload.wikimedia.org/wikipedia/en/2/2e/La_danse_%28I%29_by_Matisse.jpg", year: '1909', century: '20th', medium: 'painting'}]

richter_art = [{title: "Candle", image: 'https://www.gerhard-richter.com/datadir/images_new/xxlarge/15329.jpg', year: '1982', century: '20th', medium: 'painting'}]

cezanne_art = [{title: "Self-portrait", image: 'https://upload.wikimedia.org/wikipedia/commons/8/83/Paul_C%C3%A9zanne_149.jpg', year: '1875', century: '19th', medium: 'painting'}]

martin_list = [{title: "Friendship", image: 'http://images.tate.org.uk/sites/default/files/images/friendship.jpg', year: '1963', century: '20th', medium: 'painting'}]

bourgeois_list = [{title: "Maman", image: 'http://65.media.tumblr.com/tumblr_m18wnh4lyp1r80kxto2_1280.jpg', year: '1999', century: '20th', medium: 'sculpture'}]

lewitt_list = [{title: "Successive Rows of Horizontal, Straight Lines from Top to Bottom, and Vertical, Straight Lines from Left to Right", image: 'http://23gallery.com/wp-content/uploads/2013/11/sol_le_witt_grid-1010x1024.jpg', year: '1972', century: '20th', medium: 'wall drawing'}]

baldessari_list = [{title: "Throwing Three Balls in the Air", image: 'http://www.nationalacademy.org/wp-content/uploads/2013/09/1973-John-Baldessari-Throwing-three-balls-in-the-air.jpeg', year: '1973', century: '20th', medium: 'photograph'}]

#new_art_list = [{title: "", image: '', year: '', century: '', medium: ''}]

# artists
#new_artist = {name: "", birth: "", death: "", nationality: ""}
vermeer = {name: "Johannes Vermeer", birth: "1632", death: "1675", nationality: "Dutch"}
van_gogh = {name: "Vincent van Gogh", birth: "1853", death: "1890", nationality: "Dutch"}
rembrandt = {name: "Rembrandt Harmensz. van Rijn", birth: "1606", death: "1669", nationality: "Dutch"}
matisse = {name: "Henri Matisse", birth: "1869", death: "1954", nationality: "French"}
richter = {name: "Gerhard Richter", birth: "1932", death: "", nationality: "German"}
cezanne = {name: "Paul Cézanne", birth: "1839", death: "1906", nationality: "French"}
martin = {name: "Agnes Martin", birth: "1912", death: "2004", nationality: "American"}
bourgeois = {name: "Louise Bourgeois", birth: "1911", death: "2010", nationality: "French-American"}
lewitt = {name: "Sol Lewitt", birth: "1928", death: "2007", nationality: "American"}
baldessari = {name: "John Baldessari", birth: "1931", death: "", nationality: "American"}
#new_artist = {name: "", birth: "", death: "", nationality: ""}

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
add_art(matisse, matisse_art)
add_art(richter, richter_art)
add_art(cezanne, cezanne_art)
add_art(martin, martin_art)
add_art(bourgeois, bourgeois_art)
add_art(lewitt, lewitt_art)
add_art(baldessari, baldessari_art)

puts "Created #{Artist.count} artists, and #{Art.count} paintings."
