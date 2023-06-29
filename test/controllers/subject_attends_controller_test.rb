require "test_helper"

class SubjectAttendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subject_attend = subject_attends(:one)
  end

  test "should get index" do
    get subject_attends_url
    assert_response :success
  end

  test "should get new" do
    get new_subject_attend_url
    assert_response :success
  end

  test "should create subject_attend" do
    assert_difference('SubjectAttend.count') do
      post subject_attends_url, params: { subject_attend: { subject_id: @subject_attend.subject_id, user_id: @subject_attend.user_id } }
    end

    assert_redirected_to subject_attend_url(SubjectAttend.last)
  end

  test "should show subject_attend" do
    get subject_attend_url(@subject_attend)
    assert_response :success
  end

  test "should get edit" do
    get edit_subject_attend_url(@subject_attend)
    assert_response :success
  end

  test "should update subject_attend" do
    patch subject_attend_url(@subject_attend), params: { subject_attend: { subject_id: @subject_attend.subject_id, user_id: @subject_attend.user_id } }
    assert_redirected_to subject_attend_url(@subject_attend)
  end

  test "should destroy subject_attend" do
    assert_difference('SubjectAttend.count', -1) do
      delete subject_attend_url(@subject_attend)
    end

    assert_redirected_to subject_attends_url
  end
end
