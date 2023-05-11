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


Category.create([
  { name: 'カテゴリ1' },
  { name: 'カテゴリ2' },
  { name: 'カテゴリ3' },
  { name: 'カテゴリ4' },
  { name: 'カテゴリ5' }
])
