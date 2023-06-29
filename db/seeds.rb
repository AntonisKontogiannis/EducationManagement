# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
GlobalSetting.create(title: "professor_password", value: "professor")
GlobalSetting.create(title: "admin_password", value: "admin")
Semester.create(en_title: "1st Semester", gr_title: "1ο Εξάμμηνο")
Semester.create(en_title: "2nd Semester", gr_title: "2ο Εξάμμηνο")
Semester.create(en_title: "3rd Semester", gr_title: "3ο Εξάμμηνο")
(4..10).each do |n|
    Semester.create(en_title: "#{n}th Semester", gr_title: "#{n}ο Εξάμμηνο")
end