# README

How to run: clone this repo, bundle, run `rake db:migrate` && `rake db:seed`, `rails s`

1. Encode your name (email for admin) and password with BASE64 like that:

`Base64.encode64("harris@example.com:strongPassword1")`

` => "aGFycmlzQGV4YW1wbGUuY29tOnN0cm9uZ1Bhc3N3b3JkMQ==\n"`

2. Get token:

`curl http://localhost:3000/token -H 'Authorization: Basic aGFycmlzQGV4YW1wbGUuY29tOnN0cm9uZ1Bhc3N3b3JkMQ==\n'`

` => {"token":"0647bef020323dcaa1f3af918a717d94"}`

3. Use this token to access json api:

* Show all users
`curl http://localhost:3000/users.json -H 'Authorization: Token token=0647bef020323dcaa1f3af918a717d94'`

* Create new user
`curl http://localhost:3000/users -d '{"user":{"name":"Julia","password":"789"}}' -H "Content-type: application/json" -H 'Authorization: Token token=0647bef020323dcaa1f3af918a717d94'`

* Admins can filter tasks by user_id and state:
`curl http://localhost:3000/tasks -d '{"filter_by_user_id":"1"}' -H "Content-type: application/json" -H 'Authorization: Token token=0647bef020323dcaa1f3af918a717d94'`

* Update task (assign to user)
`curl http://localhost:3000/tasks/1 -X PUT -d '{"task":{"user_id":"5"}}' -H "Content-type: application/json" -H 'Authorization: Token token=0647bef020323dcaa1f3af918a717d94'`

* Delete task
`curl http://localhost:3000/tasks/1.json -X DELETE -H 'Authorization: Token token=0647bef020323dcaa1f3af918a717d94'`

    etc. Full list of options see in the code.
