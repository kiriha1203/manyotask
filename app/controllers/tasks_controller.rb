class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 10

  def index
    @tasks = current_user.tasks
    if params[:search].present?
      if params[:name_search].present? && params[:status_search].present?
        @tasks = @tasks.name_like(params[:name_search]).status_search(params[:status_search]).order("#{params[:column]} #{params[:sort]}").page(params[:page]).per(PER)
      elsif params[:name_search].present?
        @tasks = @tasks.name_like(params[:name_search]).order("#{params[:column]} #{params[:sort]}").page(params[:page]).per(PER)
      elsif params[:status_search].present?
        @tasks = @tasks.status_search(params[:status_search]).order("#{params[:column]} #{params[:sort]}").page(params[:page]).per(PER)
      else
        @tasks = @tasks.order("#{params[:column]} #{params[:sort]}").page(params[:page]).per(PER)
      end
    elsif params[:sort].present?
      @tasks = @tasks.order("#{params[:column]} #{params[:sort]}").page(params[:page]).per(PER)
    else
      @tasks = @tasks.recent.page(params[:page]).per(PER)
    end
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_url, notice: "タスク「#{@task.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"

  end

  private

  def task_params
    params.require(:task).permit(:name, :content, :end_deadline, :status, :priority)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end


end
