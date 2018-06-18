Admin.create(name: 'Harris', email: 'harris@example.com', password: 'strongPassword1')
Admin.create(name: 'Irwin', email: 'irwin@example.com', password: 'strongPassword2')

User.create([{name: 'Alice', password: '123'},
             {name: 'Beatrice', password: '234'},
             {name: 'Charlotte', password: '345'},
             {name: 'Eloise', password: '456'},
             {name: 'Fidela', password: '567'},
             {name: 'Grace', password: '678'}])

Task.create([{description: 'Take a dog for a walk', reward: 4, user_id: 1},
             {description: 'Plant something in the garden', reward: 5, user_id: 1},
             {description: 'Wash a real car', reward: 6, user_id: 2},
             {description: 'Play with a ball', reward: 1, user_id: 3},
             {description: 'Take some books outside and read under a tree', reward: 4},
             {description: 'Water the flowers', reward: 3},
             {description: 'Pick some apples from a tree', reward: 4},
             {description: 'Dye the fence', reward: 7}])
