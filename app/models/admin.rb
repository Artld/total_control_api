class Admin < ApplicationRecord
  before_create -> { self.auth_token = SecureRandom.hex }
end
