# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    user = create(:user)

    sign_in_as(user)
  end

  test 'visiting the index' do
    book = create(:book)

    visit books_url

    assert_selector 'h1', text: '本'
    assert_text book.title
    assert_text book.memo
    assert_text book.author
    assert_text book.picture
  end

  test 'creating a Book' do
    book = build(:book)

    visit books_url

    click_on '新規作成'

    fill_in 'タイトル', with: book.title
    fill_in 'メモ', with: book.memo
    fill_in '著者', with: book.author
    attach_file '画像', file_fixture('no-image.png')

    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text book.title
    assert_text book.memo
    assert_text book.author
    assert_selector "img[src$='no-image.png']" # 表示されているファイルの中身がアップロードしたファイルと同じかどうか検証するのは手間がかかるため、ファイル名のみを検証することとした
  end

  test 'updating a Book' do
    create(:book)
    book = build(:book)

    visit books_url

    click_on '編集', exact: true

    fill_in 'タイトル', with: book.title
    fill_in 'メモ', with: book.memo
    fill_in '著者', with: book.author
    attach_file '画像', file_fixture('no-image.png')

    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text book.title
    assert_text book.memo
    assert_text book.author
    assert_selector "img[src$='no-image.png']"
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
    assert_no_text book.picture
  end
end
