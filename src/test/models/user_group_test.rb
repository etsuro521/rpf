require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
  end
  
  test 'user_group created when group created' do
    @groups = @user.groups.build()
    assert UserGroup.first
  end
end
