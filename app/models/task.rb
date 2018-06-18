class Task < ApplicationRecord
  belongs_to :user, required: false
end
