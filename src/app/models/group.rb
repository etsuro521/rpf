class Group < ApplicationRecord
    has_many :user_groups, dependent: :destroy
    has_many :members, through: :user_groups, source: :user, dependent: :destroy
    has_many :tasks, dependent: :destroy
    has_many :tasks_users, through: :tasks, source: :user, dependent: :destroy
    has_many :teams, dependent: :destroy

    validates :name, presence: true, length: { maximum: 255 }

    #groupを最初に作ったuserをteamに追加
    def add_first_user(user)
        if members.length == 0
            members << user
            @user_group = user_groups.find_by(user_id:user.id)
            @user_group.update(admin:true)
        end
    end

    #groupとuserの関連付け,user_groupsデータを作成
    def add_user(user)
        members << user
    end

    #groupからuserが検索された時、そのgroupに参加しているか判定
    def user_added?(user)
        !members.include?(user)
    end
end
