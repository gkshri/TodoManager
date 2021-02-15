class Todo < ActiveRecord::Base
  validates :todo_text, presence: true
  validates :due_date, presence: true
  validates :todo_text, length: {minimum: 2}

  belongs_to :user

  def to_displayable_string
    isCompleted = completed ? "[X]" : "[ ]"
    "#{id} #{due_date.to_s(:long)} #{todo_text} #{isCompleted}"
  end
  
  def self.overdue
    all.where("due_date < ? and completed = ?", Date.today, false)
  end

  def self.due_today
    all.where(due_date: Date.today)
  end
  
  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def self.isCompleted
    all.where(completed: true)
  end

  def self.of_user(user)
    all.where(user_id: user.id)
  end


end