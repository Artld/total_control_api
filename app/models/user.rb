class User < ApplicationRecord
  has_many :tasks
  before_create -> { self.auth_token = SecureRandom.hex }

  def get_reward(reward)
    self[:account] += reward
    save!
  end
end
