class Goal < ActiveRecord::Base
  validates :goal_title, :completion, :user_id, presence: true
  validates :hidden, inclusion: [true, false]

  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"
end
