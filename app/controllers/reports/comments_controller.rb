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

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
