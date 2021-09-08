# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  include CommentsPersistenceActions

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def comment_new_view
    'reports/show'
  end
end
