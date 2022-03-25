require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  
  context "Regular User" do
    setup do
      @user = create(:user, role: User::REGULAR_USER_ROLE)
      @other_user = create(:user, role: User::REGULAR_USER_ROLE)
      
      @ability = Ability.new(@user)
    end
    
    should "request actions, can create, see own, and that's it" do    
      request = create(:data_request, requested_by: @user)
      request_other = create(:data_request, requested_by: @other_user)          
      
      assert @ability.can?(:read, request), "Should be able to see his own"
      assert @ability.cannot?(:read, request_other), "Should not be able to read other data request"
      
      assert @ability.cannot?(:update, request), "Shouldn't be able to update his own request"
      assert @ability.cannot?(:update, request_other), "Shouldn't be able to update other's request"
      
      assert @ability.cannot?(:destroy, request), "Shouldn't be able to destroy his own request"
      assert @ability.cannot?(:destroy, request_other), "Shouldn't be able to destroy other's request"      
    end
    
    should "attachment actions, can read if request is owned, that's it" do
      request = create(:data_request, requested_by: @user)
      request_other = create(:data_request, requested_by: @other_user)
      attachment = create(:attachment, data_request: request)
      attachment_other = create(:attachment, data_request: request_other)
      
      assert @ability.can?(:read, attachment)
      assert @ability.cannot?(:read, attachment_other)      
      
      assert @ability.cannot?(:create, Attachment)
      assert @ability.cannot?(:update, attachment)
      assert @ability.cannot?(:update, attachment_other)      
    end
  
    should "not be able to create users or see other others" do
      
      assert @ability.can?(:requests, @user), "Should see his own requests"
      assert @ability.cannot?(:requests, @other_user), "Shouldn't see other requests"
      
      assert @ability.can?(:read, @user), "Should be able to see his own info"
      assert @ability.cannot?(:read, @other_user), "Shouldn't be able to see other's info"      
    end  
    
  end
  
  context "STAFF USER" do
    setup do
      @user = create(:user, role: User::STAFF_ROLE)
      @other_user = create(:user, role: User::REGULAR_USER_ROLE)
      
      @ability = Ability.new(@user)
    end
    
    should "only see users, can't create or update" do
      assert @ability.can?(:read, @user)
      assert @ability.can?(:read, @other_user)
      
      assert @ability.cannot?(:update, @user)
      assert @ability.cannot?(:update, @other_user)      
      
      assert @ability.cannot?(:crate, User)
    end
  end
  
  context "MANAGER USER" do
    setup do
      @user = create(:user, role: User::MANAGER_ROLE)      
      @ability = Ability.new(@user)
    end
    
    should "can manage all" do
      assert @ability.can?(:manage, :all)
    end
  end
end