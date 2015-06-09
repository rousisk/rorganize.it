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

    if @notification.save
      redirect_to notification_path(@notification), notice: 'A new notification was created. This calls for cake!'
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
end
