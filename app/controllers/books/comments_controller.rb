# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  def create
    @book    = Book.find(params[:book_id])
    @comment = @book.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @book, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  def edit
    @book    = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])

    render 'comments/edit'
  end

  def update
    @book    = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @book, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render 'comments/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @book    = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])

    @comment.destroy

    redirect_to @book, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
