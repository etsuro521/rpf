module GroupsHelper

    def admin_user?(group,user)
        user.user_groups.find_by(group_id:group.id).admin
    end

    def has_group?(user)
        user.user_groups.count > 1 
    end

    def my_task?
        current_group.name == 'My Task'
    end

    def first_group?(user)
        user.join_groups.count == 2 #マイタスクと一番最初に作ったグループで２個
    end

    def first_user?(group)
        group.members.count ==1
    end
    
    def remember_group(group)
        cookies.permanent.signed[:group_id] = group.id
    end

    def current_group
        if group_id = cookies.signed[:group_id]
            @current_group = current_user.join_groups.find_by(id:group_id)
        end

        if @current_group 
            return @current_group
        else
            remember_group(current_user.join_groups.first)
            return current_user.join_groups.first
        end
    end

end
