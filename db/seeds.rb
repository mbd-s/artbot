#sample query strings to build db

# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Johannes+Vermeer&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Vincent+van+Gogh&type=painting&imgonly=True'
# 'https://www.rijksmuseum.nl/api/en/collection?' + ENV['RIJKMUSEUM_API_TOKEN'] + '&format=json&maker=Rembrandt+Harmensz.+van+Rijn&type=painting&imgonly=True'
# single object by objectNumber 'https://www.rijksmuseum.nl/api/en/collection/SK-C-251?' + 'key=ENV['RIJKMUSEUM_API_TOKEN']' + '&format=json'
Art.destroy_all
Artist.destroy_all
puts "All old artworks and artists have been cleared."

# art lists
vermeer_art = [
  {title: 'Woman Reading a Letter', image: 'http://lh3.ggpht.com/_hNgP8xlzkSVD_XfBIy3j6BSWyGqdc0N921xFJbXG7jwFbQ7hi8IuTO6AIAsQf_RI3_dt4_EEncuuLY5pVO0vT50qpY=s0', year: '1663', century: '17th', medium: 'painting'},
  {title: 'The Milkmaid', image: 'http://lh3.ggpht.com/XUw3NdeiA0MsT-mygp8NT1oPUd17GB3BK2nSRYvyTAY-N64KwsLOO5QU3muSDEk2AdMzonIVLgjge581mOobVqsQrA=s0', year: '1660', century: '17th', medium: 'painting'},
  {title: 'The Love Letter', image: 'http://lh4.ggpht.com/cIUsjrkQbRd5BMh9nv7nxib8lKisKC0CEmUdJTFvRkcqaT65EyLwQH8fBnBSY8tAnprq4VzGfIQ1sVbp6h0vAWWf4vEW=s0', year: '1669', century: '17th', medium: 'painting'},
  {title: 'The Procuress', image: 'https://upload.wikimedia.org/wikipedia/commons/8/84/Jan_Vermeer_van_Delft_002.jpg', year: '1656', century: '17th', medium: 'painting'},
  {title: 'The Little Street', image: 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Jan_Vermeer_van_Delft_025.jpg', year: '1658', century: '17th', medium: 'painting'}
]
van_gogh_art = [
  {title: 'Self-portrait', image: 'http://lh4.ggpht.com/RKAJ3z2mOcw83Ju0a7NIp71oUoJbVWJQzxwki5PSERissvWIrELCuxxGZ12U0PeAnf6WLkRCzpFdvjweUBjlcr2I4dl_=s0', year: '1887', century: '19th', medium: 'painting'}
]
rembrandt_art = [
  {title: "Militia Company of District II under the Command of Captain Frans Banninck Cocq, Known as the 'Night Watch'", image: 'http://lh6.ggpht.com/ZYWwML8mVFonXzbmg2rQBulNuCSr3rAaf5ppNcUc2Id8qXqudDL1NSYxaqjEXyDLSbeNFzOHRu0H7rbIws0Js4d7s_M=s0', year: '1642', century: '17th', medium: 'painting'}
]
matisse_art = [
  {title: "Dance (I)", image: "https://upload.wikimedia.org/wikipedia/en/2/2e/La_danse_%28I%29_by_Matisse.jpg", year: '1909', century: '20th', medium: 'painting'}
]
richter_art = [
  {title: "Candle", image: 'https://www.gerhard-richter.com/datadir/images_new/xxlarge/15329.jpg', year: '1982', century: '20th', medium: 'painting'}
]
cezanne_art = [
  {title: "Self-portrait", image: 'https://upload.wikimedia.org/wikipedia/commons/8/83/Paul_C%C3%A9zanne_149.jpg', year: '1875', century: '19th', medium: 'painting'}
]
martin_art = [
  {title: "Friendship", image: 'http://images.tate.org.uk/sites/default/files/images/friendship.jpg', year: '1963', century: '20th', medium: 'painting'}
]
bourgeois_art = [
  {title: "Maman", image: 'http://65.media.tumblr.com/tumblr_m18wnh4lyp1r80kxto2_1280.jpg', year: '1999', century: '20th', medium: 'sculpture'}
]
lewitt_art = [
  {title: "Successive Rows of Horizontal, Straight Lines from Top to Bottom, and Vertical, Straight Lines from Left to Right", image: 'http://23gallery.com/wp-content/uploads/2013/11/sol_le_witt_grid-1010x1024.jpg', year: '1972', century: '20th', medium: 'wall drawing'}
]
baldessari_art = [
  {title: "Throwing Three Balls in the Air", image: 'http://www.nationalacademy.org/wp-content/uploads/2013/09/1973-John-Baldessari-Throwing-three-balls-in-the-air.jpeg', year: '1973', century: '20th', medium: 'photograph'}
]
botticelli_art = [
 {title: "Primavera", image: 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Botticelli-primavera.jpg', year: '1482', century: '15th', medium: 'painting'}
]
raphael_art = [
  {title: "Portrait of a Lady with a Unicorn", image: 'https://legionofhonor.famsf.org/files/styles/exhibition_main/public/exhibitions/raphael_1.jpg', year: '1506', century: '16th', medium: 'painting'}
]
bosch_art = [
  {title: "The Garden of Earthly Delights", image: 'https://upload.wikimedia.org/wikipedia/commons/a/ae/El_jard%C3%ADn_de_las_Delicias,_de_El_Bosco.jpg', year: '1510', century: '16th', medium: 'painting'},
  {title: "The Last Judgment", image: 'https://upload.wikimedia.org/wikipedia/commons/4/47/Last_judgement_Bosch.jpg', year: '1482', century: '15th', medium: 'painting'}
]
da_vinci_art = [
  {title: "Madonna Litta", image: 'https://www.hermitagemuseum.org/wps/wcm/connect/9576be8c-67ef-42fb-95e2-3b27ef9f9708/WOA_IMAGE_1.jpg?MOD=AJPERES&CACHEID=9e1595c9-eab8-45fa-a423-10a83cb34a10', year: '1490', century: '15th', medium: 'painting'}
]
warhol_art = [
  {title: "Elvis I & II", image: 'http://artscenecal.com/ArtistsFiles/WarholA/WarholAJPGs/AWarhol18D.jpg', year: '1963', century: '20th', medium: 'painting'}
]
durer_art = [
  {title: "Self-portrait at 26", image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Selbstportr%C3%A4t,_by_Albrecht_D%C3%BCrer,_from_Prado_in_Google_Earth.jpg/811px-Selbstportr%C3%A4t,_by_Albrecht_D%C3%BCrer,_from_Prado_in_Google_Earth.jpg', year: '1498', century: '15th', medium: 'painting'}
]
picasso_art = [
  {title: "Woman with Bangs", image: "https://upload.wikimedia.org/wikipedia/en/2/25/Pablo_Picasso%2C_1902%2C_Woman_with_Bangs%2C_61.3_x_51.4_cm%2C_The_Baltimore_Museum_of_Art%2C_Maryland.jpg", year: '1902', century: '20th', medium: 'painting'}
]
#new_art = [
# {title: "", image: '', year: '', century: '', medium: ''}
# ]

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
botticelli = {name: "Sandro Botticelli", birth: "1445", death: "1510", nationality: "Italian"}
raphael = {name: "Raphael", birth: "1483", death: "1520", nationality: "Italian"}
bosch = {name: "Hieronymus Bosch", birth: "1450", death: "1516", nationality: "Dutch"}
da_vinci = {name: "Leonardo da Vinci", birth: "1452", death: "1519", nationality: "Italian"}
warhol = {name: "Andy Warhol", birth: "1928", death: "1987", nationality: "American"}
durer = {name: "Albrecht Dürer", birth: "1471", death: "1528", nationality: "German"}
picasso = {name: "Pablo Picasso", birth: "1881", death: "1973", nationality: "Spanish"}
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
add_art(botticelli, botticelli_art)
add_art(raphael, raphael_art)
add_art(bosch, bosch_art)
add_art(da_vinci, da_vinci_art)
add_art(warhol, warhol_art)
add_art(durer, durer_art)
add_art(picasso, picasso_art)
#add_art(artist, artist_art)

puts "Created #{Artist.count} artists, and #{Art.count} paintings."
