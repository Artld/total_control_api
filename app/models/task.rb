class Task < ApplicationRecord
  belongs_to :user, required: false
  validates :state, acceptance: { accept: ['open', 'in progress', 'done', 'verified', 'failed'] }
end
