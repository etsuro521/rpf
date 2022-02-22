require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @task = tasks(:most_recent)
  end

  test "should redirect create when not logged in " do
    assert_no_difference 'Task.count' do
      post tasks_path, params: {task: {title: "task1", deadline: Date.today, urgency_importance: "4", status: "未着手", notes: "要検討" }}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Task.count' do
      delete task_path(@task)
    end
    assert_redirected_to login_url
  end

end
