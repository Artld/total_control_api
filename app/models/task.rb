class Task < ApplicationRecord
  belongs_to :user, required: false
  validates :state, acceptance: { accept: ['open', 'in progress', 'done', 'verified', 'failed'] }

  def decrease_reward
    self[:reward] -= 1 if self[:reward] > 1
    save!
  end
end
