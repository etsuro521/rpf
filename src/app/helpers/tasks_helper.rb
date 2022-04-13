module TasksHelper
    def progress(task)
        deadline = task.deadline.to_datetime
        if task.status == '完了'
            progress = 'finish'  
        elsif deadline - DateTime.now <= 0
            progress = 'late'     
        elsif deadline - DateTime.now <= 1
            progress = 'warn'
        
        end        
    end

    def from(task)
        if task.from.empty?
            name = ""
            return name
        else
            user = User.find_by(id:task.from)
            name = user.nil? ? "" : user.name
        end
    end

    def to(task)
        user = User.find_by(id:task.to)
        name = user.nil? ? "" : user.name
    end

    def updater(task)
        user = User.find_by(id:task.updater)
        name = user.nil? ? "" : user.name
    end
end
