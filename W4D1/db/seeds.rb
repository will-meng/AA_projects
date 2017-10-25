# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
u1 = User.create(username: 'evilDude')
u2 = User.create(username: 'bobross@yahoo.com')
u3 = User.create(username: 'theseed@gmail.com')

Artwork.delete_all
art1 = Artwork.create(title: "starry night", artist_id: u1.id, image_url: "google.com" )
art2 = Artwork.create(title: "happy pillows", artist_id: u3.id, image_url: "facebook.com" )
art3 = Artwork.create(title: "day in the park", artist_id: u1.id, image_url: "twitter.com" )

ArtworkShare.delete_all
artshare1 = ArtworkShare.create(artwork_id: art1.id, viewer_id: u3.id)
artshare2 = ArtworkShare.create(artwork_id: art2.id, viewer_id: u3.id)
artshare3 = ArtworkShare.create(artwork_id: art1.id, viewer_id: u2.id)
