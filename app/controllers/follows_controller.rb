# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    user = User.find(params[:user_id])

    current_user.follow!(user)

    redirect_to user, notice: t('controllers.common.notice_create', name: Follow.model_name.human)
  end

  def destroy
    user = User.find(params[:user_id])

    current_user.unfollow!(user)

    redirect_to user, notice: t('controllers.common.notice_destroy', name: Follow.model_name.human)
  end
end
