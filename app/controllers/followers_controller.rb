class FollowersController < ApplicationController
  before_action :load_user

  def index
    @title = t ".followers_title"
    @users = @user.followers.page(params[:page]).per Settings.paginates_per
    render "users/show_follow"
  end
end
