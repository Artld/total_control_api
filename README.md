# README

How to run: clone this repo, bundle, run `rake db:migrate` && `rake db:seed`, `rails s`

1. Encode your name (email for admin) and password with BASE64 like that:

`Base64.encode64("harris@example.com:strongPassword1")`

` => "aGFycmlzQGV4YW1wbGUuY29tOnN0cm9uZ1Bhc3N3b3JkMQ==\n"`

2. Get token:

`curl http://localhost:3000/token -H 'Authorization: Basic aGFycmlzQGV4YW1wbGUuY29tOnN0cm9uZ1Bhc3N3b3JkMQ==\n'`

` => {"token":"0647bef020323dcaa1f3af918a717d94"}`

3. Use this token to access json api:

`curl http://localhost:3000/users.json -H 'Authorization: Token token=0647bef020323dcaa1f3af918a717d94'`
