require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @task = @user.tasks.build(title: 'task1',deadline: DateTime.now+1,urgency_importance: 'A', status: '未着手')
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "user id should be present" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "title should be present" do
    @task.title = "  "
    assert_not @task.valid?
  end

  test "title should be at most 255 characters" do
    @task.title = "a"*256
    assert_not @task.valid?
  end

  test "status should have registered values" do
    @task.status = "aaaa"
    assert_not @task.valid?
  end

  test "urgency_importance should have registered values" do
    @task.status = "aaaa"
    assert_not @task.valid?
  end

  test "deadline should be present" do
    @task.deadline = "     "
    assert_not @task.valid?
  end

  test "deadlines should have a date after now" do
    @task.deadline = DateTime.now
    assert_not @task.valid?
  end
end
