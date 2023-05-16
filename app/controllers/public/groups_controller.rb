class Public::GroupsController < ApplicationController


  def new
    @group = Group.new
  end


  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    if @group.save
      # binding.pry
      redirect_to groups_path, notice: "グループを作成しました！"
    else
      render :new
    end
  end


  def index
    @groups = Group.all
    @group_joining = GroupUser.where(end_user_id: current_end_user.id)
    @groups_none = "グループに参加していません。"
  end


  def edit
    @group = Group.find(params[:id])
  end


  def update
    @group = Group.find(params[:id])
  end


  def group_all
    @groups = Group.all
  end




  private
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, end_user_ids: [])
  end


end
