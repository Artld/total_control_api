json.users @users do |user|
  json.name user.name
  json.id user.id

  tasks = user.tasks.to_a

  json.key_format! ->(key) { (key=='in_progress') ? 'in progress' : key}

  json.open        tasks.keep_if{|t| t.state == 'open'}.size
  json.in_progress tasks.keep_if{|t| t.state == 'in progress'}.size
  json.done        tasks.keep_if{|t| t.state == 'done'}.size
  json.verified    tasks.keep_if{|t| t.state == 'verified'}.size
  json.failed      tasks.keep_if{|t| t.state == 'failed'}.size
end
