user = User.create!(name:  "Main User",
    email: "example@railstutorial.org",
    password:              "password",
    password_confirmation: "password")

other_user = User.create!(name:  "Sample User1",
    email: "user@test1.jp",
    password:              "password",
    password_confirmation: "password")

user_mytask = Group.create!(name:"マイタスク")
other_user_mytask = Group.create!(name:"マイタスク")
user.join_groups << user_mytask
other_user.join_groups << other_user_mytask
