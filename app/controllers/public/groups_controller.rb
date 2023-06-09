class Public::GroupsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_end_user, only: [:new, :create, :index, :show, :edit, :update, :group_all]
  before_action :is_matchig_owner_user, only: [:edit, :update]


  def new
    @group = Group.new
  end


  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    @group.end_users << current_end_user
    if @group.save
      redirect_to groups_path, notice: "グループを作成しました！"
    else
      render :new
    end
  end


  def join
    @group = Group.find(params[:group_id])
    @group.end_users << current_end_user
    redirect_to group_path(@group)
  end


  def index
    @groups = current_end_user.groups.page(params[:page])
  end


  def show
  end


  def edit
  end


  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループ情報を更新しました！"
    else
      render "edit"
    end
  end


  def destroy
    @group.end_users.delete(current_end_user)
    redirect_to groups_path
  end


  def destroy_all
    @group = Group.find(params[:group_id])
    if @group.destroy
      redirect_to groups_path
    end
  end


  def group_all
    @groups = Group.all.page(params[:page])
  end




  private
  def group_params
    # params.require(:group).permit(:name, :introduction, :group_image)
    params.require(:group).permit(:name, :introduction, :group_image, end_user_ids: [])
  end


  def set_group
    @group = Group.find(params[:id])
  end


  def set_end_user
    @end_user = current_end_user
  end


  def is_matchig_owner_user
    group = Group.find(params[:id])
    unless @group.owner_id == current_end_user.id
      redirect_to groups_path
    end
  end




end
