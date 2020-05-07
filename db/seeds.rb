#user作成
2.times do |n|
  User.create(
    name: "admin#{n + 1}",
    email: "admin#{n + 1}@test.com",
    password: "password",
    password_confirmation: "password",
    admin: true
  )
end

3.times do |n|
  User.create(
    name: "test#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false
  )
end

#task作成
User.all.each do |user|
  5.times do |i|
    user.tasks.create(
      name: "#{i}番目のタスク",
      content: "#{i}番目のタスクの内容",
      end_deadline: Date.today.change(day: i+1),
      status: 0,
      priority: 0,
      user_id: user.id
    )
  end
end

User.all.each do |user|
  5.times do |i|
    user.tasks.create(
      name: "#{i}番目のタスク",
      content: "#{i}番目のタスクの内容",
      end_deadline: Date.today.change(day: i+2),
      status: 1,
      priority: 50,
      user_id: user.id
    )
  end
end

User.all.each do |user|
  5.times do |i|
    user.tasks.create(
      name: "#{i}番目のタスク",
      content: "#{i}番目のタスクの内容",
      end_deadline: Date.today.change(day: i+3),
      status: 99,
      priority: 99,
      user_id: user.id
    )
  end
end

#label作成
Label.create([
               {name: "Ruby"},
               {name: "Python"},
               {name: "GO"},
               {name: "JavaScript"}
             ])