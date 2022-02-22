class Task < ApplicationRecord
  belongs_to :user
  default_scope -> { order(updated_at: :DESC) }
  with_options presence: true do
    validates :user_id
    validates :title, length: { maximum: 255 }
    validates :deadline
    validates :urgency_importance, inclusion: { in: %w(A B C D) }
    validates :status, inclusion: { in: %w(未着手 対応中 完了) }
  end
  validates :notes, length: { maximum: 500 }
  validate :after_now, on: :create


  private
    def after_now
      if self.deadline.present? && self.deadline < DateTime.now
        errors.add(:deadline,"Cannot set a date in the past")
      end
    end
end
