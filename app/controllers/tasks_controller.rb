class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 5

  def index
    @tasks = current_user.tasks
    if params[:search].present?
      if params[:name_search].present? && params[:status_search].present?
        @tasks = @tasks.name_like(params[:name_search]).status_search(params[:status_search])
      elsif params[:name_search].present?
        @tasks = @tasks.name_like(params[:name_search])
      elsif params[:status_search].present?
        @tasks = @tasks.status_search(params[:status_search])
      end
    end
    if params[:sort].present?
      @tasks = @tasks.order("#{params[:column]} #{params[:sort]}")
    else
      @tasks = @tasks.recent.page(params[:page])
    end
    @tasks = @tasks.page(params[:page]).per(PER)
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_url, success: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to task_url, success: "タスク「#{@task.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, success: "タスク「#{@task.name}」を削除しました。"

  end

  private

  def task_params
    params.require(:task).permit(:name, :content, :end_deadline, :status, :priority)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
