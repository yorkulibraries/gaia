require 'test_helper'

class UserTest < ActiveSupport::TestCase


  should "create a valid user" do
    user = build(:user)

    assert_difference "User.count", 1 do
      user.save
    end
  end

  should "not create an invalid user" do

    assert ! build(:user, name: nil).valid?, "Name is required"
    assert ! build(:user, email: nil).valid?, "Email is required"
    assert ! build(:user, username: nil).valid?, "Username is required"
    assert ! build(:user, usertype: nil).valid?, "Usertype is required"
    assert ! build(:user, role: nil).valid?, "Role is required"

    assert ! build(:user, email: "whwoow").valid?, "Email should follow proper format"
    assert ! build(:user, role: "sdljfladjs").valid?, "Role should one of the defined roles"
    assert ! build(:user, username: "3^^#3").valid?, "Username should follow a proper format"

    create(:user, email: "email@email.com", username: "username")
    assert ! build(:user, email: "email@email.com").valid?, "Email must be unique"
    assert ! build(:user, username: "username").valid?, "Username must be unique"
  end

  should "be able to update user, only email, name and role" do
    user = create(:user, email: "email@email.com", name: "John Doe", role: User::STAFF_ROLE)

    user.update({ email: "new@email.com", name: "Bradley Johnson", role: User::REGULAR_USER_ROLE})
    user.reload
    assert_equal "new@email.com", user.email, "email changed"
    assert_equal "Bradley Johnson", user.name, "name changed"
    assert_equal User::REGULAR_USER_ROLE, user.role, "user changed"
        
  end

  should "be able to destroy user" do
    user = create(:user)

    assert_difference "User.count", -1 do
      user.destroy
    end
  end

  ### METHODS

  should "create user based on provided Passport York Unfo, Role must be Regular User" do
    passport_york_info = { username: "johndoe", usertype: "GRAD:STUDENT", name: "john doe", email: "john@doe.com"}
    assert_difference "User.count", 1 do
      user = User.find_or_create(passport_york_info)
      assert_equal "johndoe", user.username
      assert_equal "GRAD:STUDENT", user.usertype
      assert_equal "john doe", user.name
      assert_equal User::REGULAR_USER_ROLE, user.role
    end
  end

  should "return user ojbect of one is found based on passport_york_info, don't create a new one" do
    existing_user = create(:user, username: "johndoe")
    passport_york_info = { username: "johndoe", usertype: "GRAD:STUDENT", name: "john doe", email: "john@doe.com"}

    assert_no_difference "User.count" do
      user = User.find_or_create(passport_york_info)
      assert_equal "johndoe", user.username, "Loaded proper user"
      assert_equal existing_user.id, user.id, "Ids match"
    end
  end


  #### SCOPES

  should "display users sorted by name" do
    create(:user, name: "Xavier")
    create(:user, name: "Johnson")
    create(:user, name: "Appleseed")


    assert_equal "Appleseed", User.alphabetical.first.name, "First one should be appleseed"
    assert_equal "Xavier", User.alphabetical.last.name, "Last one should be xavier"
  end

  should "show not deleted users by default, and deleted with deleted scope" do
    create_list(:user, 3, deleted: true)
    create_list(:user, 2, deleted: false)

    assert_equal 2, User.all.count, "Only 2 users are not deleted"
    assert_equal 3, User.deleted.count, "There should be 3 deleted users"
  end

end
