class Team < ApplicationRecord
    belongs_to :group
    has_many :user_teams, dependent: :destroy
    has_many :members, through: :user_teams,source: :user, dependent: :destroy
    has_many :tasks, dependent: :destroy
    has_many :tasks_users, through: :tasks, source: :user, dependent: :destroy

    validates :name, presence: true, length: { maximum: 255 }

    #teamを最初に作ったuserをteamに追加
    def add_first_user(user)
        if members.length == 0
            members << user
        end
    end

    #teamとuserの関連付け,user_teamsデータを作成
    def add_user(user)
        members << user
    end

    #teamからuserが検索された時、そのteamに参加しているか判定
    def user_added?(user)
        !members.include?(user)
    end
end
