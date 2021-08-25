# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    user = create(:user)

    visit root_url

    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password

    click_on 'ログイン'
  end

  test 'visiting the index' do
    book = create(:book)

    visit books_url

    assert_selector 'h1', text: '本'
    assert_text book.title
    assert_text book.memo
    assert_text book.author
  end

  test 'creating a Book' do
    book = build(:book)

    visit books_url

    click_on '新規作成'

    fill_in 'タイトル', with: book.title
    fill_in 'メモ', with: book.memo
    fill_in '著者', with: book.author

    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text book.title
    assert_text book.memo
    assert_text book.author
  end

  test 'updating a Book' do
    create(:book)
    book = build(:book)

    visit books_url

    click_on '編集', exact: true

    fill_in 'タイトル', with: book.title
    fill_in 'メモ', with: book.memo
    fill_in '著者', with: book.author

    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text book.title
    assert_text book.memo
    assert_text book.author
  end

  test 'destroying a Book' do
    book = create(:book)

    visit books_url

    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
    assert_no_text book.title
    assert_no_text book.memo
    assert_no_text book.author
  end
end
