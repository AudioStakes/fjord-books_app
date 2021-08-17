# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  def create
    @report  = Report.find(params[:report_id])
    @comment = @report.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render 'reports/show', status: :unprocessable_entity
    end
  end

  def edit
    @report  = Report.find(params[:report_id])
    @comment = @report.comments.find(params[:id])

    render 'comments/edit'
  end

  def update
    @report  = Report.find(params[:report_id])
    @comment = @report.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render 'comments/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @report  = Report.find(params[:report_id])
    @comment = @report.comments.find(params[:id])

    @comment.destroy

    redirect_to @report, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
