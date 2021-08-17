# frozen_string_literal: true

module CommentsPersistenceActions
  extend ActiveSupport::Concern

  included do
    before_action :set_commentable, only: :create
    before_action :set_commentable_and_comment, only: %i[edit update destroy]
  end

  def edit
    render 'comments/edit'
  end

  def create
    @comment = @commentable.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render comment_new_view, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render 'comments/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_commentable
    raise NotImplementedError
  end

  def set_commentable_and_comment
    set_commentable
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_new_view
    raise NotImplementedError
  end
end
