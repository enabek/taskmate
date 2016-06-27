class GroupsController < ApplicationController
  include ApplicationHelper
  
  def show
    @group = Group.find_by(id: params[:id])
    redirect_to_user
    @members = @group.users
    @task = Task.new
    @membership = Membership.new
    @invite = Invite.new
    # Tasks this week
    @tasks_this_week = @group.tasks.where(due_date: Date.today..(Date.today + 7)).count

    @data_for_chart = {"All Tasks" => @tasks_this_week }.to_json
    # Tasks completed by each member for week
    @members.each do |member|
        member.name
        member.tasks.count
    end

  end

  

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      @membership = Membership.create(group_id: @group.id,
                                      user_id: current_user.id)
      redirect_to @group
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to '/groups/new'
    end

  end

  def destroy
    @group.destroy
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name)
    end
end
