class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!


  def index
    @groups = Group.all
  end


  def show
  end


  def edit
  end


  def update
  end


  def destroy
  end


end
