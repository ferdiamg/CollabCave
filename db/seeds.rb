# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ferdi = User.create(email: 'ferdiarmagan@web.de', password: 'ferdiamg', password_confirmation: 'ferdiamg')
maik = User.create(email: 'maikreinicke@yahoo.de', password: 'maik123', password_confirmation: 'maik123')

ferdi.beats.new(name: 'Astro', bpm: '130', key: 'F#m', link: 'https://www.dropbox.com/s/8lnnk2ts0wimhnw/Cartii%20Yachty%20C%20Minor%20150BPM%20v2.mp3')
ferdi.beats.new(name: 'Fuego', bpm: '144', key: 'D#m', link: 'https://www.dropbox.com/s/8lnnk2ts0wimhnw/Cartii%20Yachty%20C%20Minor%20150BPM%20v2.mp3')
ferdi.beats.new(name: 'Aliens', bpm: '150', key: 'F#', link: 'https://www.dropbox.com/s/huo1u4d57ubl44k/G%23%20Minor%20PartyNextDoor%20Type%20Beat%20Wus%20Good.mp3')