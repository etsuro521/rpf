class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  belongs_to :team, optional: true

  default_scope -> { order(updated_at: :DESC) }
  with_options presence: true do
    validates :user_id
    validates :group_id
    validates :title, length: { maximum: 255 }
    validates :deadline
    validates :urgency_importance, inclusion: { in: %w(A B C D) }
    validates :status, inclusion: { in: %w(未着手 対応中 完了) }
  end
  validates :notes, length: { maximum: 255 }
  validate :after_now, on: :create
  validate :should_set_to
  validate :should_set_from


  private
    def after_now
      if self.deadline.present? && self.deadline < DateTime.now
        errors.add(:deadline,"Cannot set a date in the past")
      end
    end

    def should_set_from
      if !self.from.present? && Group.find(self.group_id).name != 'My Task'
        errors.add(:from,"is required fields")
      end
    end

    def should_set_to
      if !self.to.present? && Group.find(self.group_id).name != 'My Task'
        errors.add(:to,"is required fields")
      end
    end
end
