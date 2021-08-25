# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @current_user = create(:user)

    sign_in_as(@current_user)
  end

  test 'visiting the index' do
    report = create(:report, user: @current_user)

    visit reports_url

    assert_selector 'h1', text: '日報'
    assert_text report.title
    assert_text @current_user.name_or_email
    assert_text I18n.l(report.created_on)
  end

  test 'creating a Report' do
    report = build(:report)

    visit reports_url

    click_on '新規作成'

    fill_in 'タイトル', with: report.title
    fill_in '内容', with: report.content

    # 「日報の作成」から「日報の作成日の確認」までに日付が変わらないようにするため時間を固定
    freeze_time do
      click_on '登録する'

      assert_text '日報が作成されました。'
      assert_text report.title
      assert_text report.content
      assert_text @current_user.name_or_email
      assert_text I18n.l(Time.zone.today)
    end
  end

  test 'updating a Report' do
    create(:report, user: @current_user)
    created_on = Report.last.created_on
    report     = build(:report)

    visit reports_url

    click_on '編集', exact: true

    fill_in 'タイトル', with: report.title
    fill_in '内容', with: report.content

    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text report.title
    assert_text report.content
    assert_text @current_user.name_or_email
    assert_text I18n.l(created_on)
  end

  test 'destroying a Report' do
    report = create(:report, user: @current_user)

    visit reports_url

    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が削除されました。'
    assert_no_text report.title
    assert_no_text @current_user.name_or_email
    assert_no_text I18n.l(report.created_on)
  end
end
