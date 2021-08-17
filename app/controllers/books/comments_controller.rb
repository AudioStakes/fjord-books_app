# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  include CommentsPersistenceActions

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end

  def comment_new_view
    'books/show'
  end
end
