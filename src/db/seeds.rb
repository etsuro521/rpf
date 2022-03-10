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
group = Group.create!(name:'sample_group1')
user.join_groups << [user_mytask,group]
other_user.join_groups << [other_user_mytask,group]

general = group.teams.create!(name:'general')
user_general = user_mytask.teams.create!(name:'general')
other_user_general = other_user_mytask.teams.create!(name:'general')
team = group.teams.create!(name:'sample_team1')
user.join_teams << [general,team,user_general]
other_user.join_teams << [general,team,other_user_general]

