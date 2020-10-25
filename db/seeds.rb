# coding: utf-8

User.create!( name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin:true)
              
60.times do|n|
 name = Faker::Name.name
 email = "sample-#{n+1}@email.com"
 password = "password"
 User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

Task.create!( name: "管理者",
              description: "サンプル詳細")
              
50.times do|n|
 name = Faker::Name.name
 description = "サンプル詳細#{n+1}"
 Task.create!(name: name,
              description: description)
end