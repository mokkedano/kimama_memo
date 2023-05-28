# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create!(
  email: 'admin@admin',
  password: 'testadmin'
)


end_users = EndUser.create!(
  [
    {email: 'haru@kaze', nickname: 'はる', password: 'kazetuyoi', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-end-user1.jpg"), filename:"sample-end-user1.jpg")},
    {email: 'umi@natsu', nickname: 'なつ', password: 'atsusugi', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-end-user2.jpg"), filename:"sample-end-user2.jpg")},
    {email: 'aki@kuri', nickname: 'あき', password: 'akikaze', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-end-user3.jpg"), filename:"sample-end-user3.jpg")},
    {email: 'yuki@fuyu', nickname: 'ふゆ', password: 'shinshin', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-end-user4.jpg"), filename:"sample-end-user4.jpg")}
  ]
)
