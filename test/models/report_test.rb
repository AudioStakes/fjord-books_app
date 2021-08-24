# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?(target_user) returns true when created by the target user' do
    alice  = create(:user)
    report = create(:report, user: alice)

    assert report.editable?(alice)
  end

  test '#editable?(target_user) returns false when not created by the target user' do
    alice  = create(:user)
    bob    = create(:user)
    report = create(:report, user: bob)

    assert_not report.editable?(alice)
  end

  test '#created_on returns a created date' do
    report = create(:report)

    assert_equal report.created_at.to_date, report.created_on
  end
end
