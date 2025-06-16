class Task < ApplicationRecord
    belongs_to :user


    validates :due_date, presence: true
    validate  :due_date_must_be_in_future
    
    enum priority: { low: 0, medium: 1, high: 2 }


    private
    def due_date_must_be_in_future
      if due_date.present? && due_date < DateTime.now
        errors.add(:due_date, "must be in the future")
      end
    end
end
