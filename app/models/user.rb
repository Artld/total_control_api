class User < ApplicationRecord
  has_many :tasks
  before_create -> { self.auth_token = SecureRandom.hex }
end
