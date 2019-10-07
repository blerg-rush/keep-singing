# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Video.skip_callback(:save, :before, :add_details)

Video.create(title: 'Most Beautiful Girl in the Room',
             link: 'https://www.youtube.com/watch?v=QKnXM5G8lRE',
             uid: 'QKnXM5G8lRE',
             description: 'Flight of the Conchords   Most Beautiful Girl in the Room Karaoke',
             channel_id: 'UCCzFM7I3PHCrj4GEwpI4jgw')

Video.set_callback(:save, :before, :add_details)
