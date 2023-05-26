class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!


  def index
    @groups = Group.all.order('id DESC').page(params[:page]).per(10)
  end


  def show
    @group = Group.find(params[:id])
  end


  def edit
  end


  def update
  end


  def destroy
  end


end
