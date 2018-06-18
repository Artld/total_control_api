if @is_admin
  json.partial! "users/user", user: @user
else
  json.id      @user.id
  json.name    @user.name
  json.account @user.account

  tasks = @user.tasks.to_a

  json.key_format! ->(key) { (key=='in_progress') ? 'in progress' : key}

  json.open        tasks.keep_if{|t| t.state == 'open'}.size
  json.in_progress tasks.keep_if{|t| t.state == 'in progress'}.size
  json.done        tasks.keep_if{|t| t.state == 'done'}.size
  json.verified    tasks.keep_if{|t| t.state == 'verified'}.size
  json.failed      tasks.keep_if{|t| t.state == 'failed'}.size
end
