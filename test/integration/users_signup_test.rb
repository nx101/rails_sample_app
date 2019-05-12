require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # check that a failed submission re-renders the new action
    assert_template 'users/new'

    # tests for error msgs
    # by css id for error explanation
    assert_select 'div#error_explanation'
    # CSS class for fields with error
    assert_select 'div.field_with_errors'

    # test correct post path for form
    # by presence of the form tag
    assert_select 'form[action="/signup"]'

  end


  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end

    # follow the redirect_to in the code and test the template
    follow_redirect!
    assert_template 'users/show'
    # test for a non-empty flash msg (ow brittle)
    assert_not flash.empty?
    # test auto-login after save
    assert is_logged_in?

  end








end