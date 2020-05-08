class Admin::LabelsController < ApplicationController
  before_action :require_admin
  before_action :set_label, only: [:edit, :update, :destroy]

  layout 'admin_application'

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_labels_url, success: "「#{@label.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @label.update(label_params)
      redirect_to admin_labels_url, success: "ユーザー「#{@label.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to admin_labels_url, success: "タスク「#{@label.name}」を削除しました。"
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end

