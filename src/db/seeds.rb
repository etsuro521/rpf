User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar")

user = User.first
status_list = ['未着手','対応中','完了']
importance = ['A','B','C','D']
50.times do |i|
    title = 'Task' + i.to_s
    deadline = DateTime.now + i + 1
    urgency_importance = importance[i%4]
    status = status_list[i%3]
    notes = Faker::Lorem.sentence(word_count: 10)
    user.tasks.create!(title:title, deadline:deadline, urgency_importance:urgency_importance, status:status, notes:notes) 
end