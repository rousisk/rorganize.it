class NotificationsController < ApplicationController

  before_action :authenticate_person!

  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)

    @notification.person = Person.find(params[:notification][:person_id].to_i)
    @notification.group = Group.find(params[:notification][:group_id].to_i)

    if @notification.save
      redirect_to notifications_path, notice: 'A new notification was created. This calls for cake!'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @notification.update_attributes notification_params
      redirect_to notification_path(@notification), notice: 'Notification was updated. Let\'s have some cake.'
    else
      render action: 'edit'
    end
  end

  def show
    # notifications = Notification.where(notification_id: @notification.id)
  end

  def destroy
    @notification.destroy
    redirect_to notifications_path, notice: 'Notification was successfully deleted.'
  end

  private

  def notification_params
    params.require(:notification).permit(:person, :group, :content)
  end
end
