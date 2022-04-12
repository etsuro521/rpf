def step_by_unit(head,tail, unit = :day, step = 1)  
    Enumerator.new do |yielder|
      while head <= tail
        yielder << head
        head += step.send(unit)
      end
    end
end

def get_months(now)
    head = Date.new(now.year,1)
    tail = Date.new(now.year,12)
    months = step_by_unit(head,tail,:month)
end

user = User.create!(name:  "Main User",
    email: "example@railstutorial.org",
    password:              "password",
    password_confirmation: "password")

other_user = User.create!(name:  "Sample User1",
    email: "user@test1.jp",
    password:              "password",
    password_confirmation: "password")

user_mytask = Group.create!(name:"My Task")
other_user_mytask = Group.create!(name:"My Task")
group = Group.create!(name:'sample_group1')
user.join_groups << [user_mytask,group]
user.user_groups.find_by(group_id:group.id).update(admin:true)
other_user.join_groups << [other_user_mytask,group]

general = group.teams.create!(name:'general')
user_general = user_mytask.teams.create!(name:'general')
other_user_general = other_user_mytask.teams.create!(name:'general')
team = group.teams.create!(name:'sample_team1')
user.join_teams << [general,team,user_general]
other_user.join_teams << [general,team,other_user_general]

weeks = ["１週目", "２週目", "３週目", "４週目", "５週目"]
whose = ["0",user.id]
24.times do |i|
    team.weekly_goals.create!(
        month: DateTime.new(2022,12,1) << i,
        week: weeks[i%5],
        whose: whose[i%2],
        plan: ("sample_week_plan" + i.to_s)*6,
        action: ("sample_week_action" + i.to_s)*6
    )
end


pri = ["A","B","C","D"]
status = ["未着手","対応中","完了"]
users = [user,other_user]
teams = [general,team]
100.times do |i|
    user.tasks.create!(
        title:"task" + i.to_s,
        deadline: DateTime.now + i + 1,
        urgency_importance: pri[i%4],
        status: status[i%3],
        from: users[i%2].id,
        to: users[i%2].id,
        group_id:group.id,
        team_id:team.id
    )
end

