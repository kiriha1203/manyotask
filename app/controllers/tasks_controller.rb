class TasksController < ApplicationController
  def index
    @tasks = Task.all
    if params[:search].present?
      if params[:name_search].present? && params[:status_search].present?
        @tasks = @tasks.name_like(params[:name_search]).status_search(params[:status_search]).order("#{params[:column]} #{params[:sort]}")
      elsif params[:name_search].present?
        @tasks = @tasks.name_like(params[:name_search]).order("#{params[:column]} #{params[:sort]}")
      elsif params[:status_search].present?
        @tasks = @tasks.status_search(params[:status_search]).order("#{params[:column]} #{params[:sort]}")
      else
        @tasks = @tasks.order("#{params[:column]} #{params[:sort]}")
      end
    elsif params[:sort].present?
      @tasks = @tasks.order("#{params[:column]} #{params[:sort]}")
    else
      @tasks = @tasks.recent
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_url, notice: "タスク「#{@task.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"

  end

  private
  def task_params
    params.require(:task).permit(:name, :content, :end_deadline, :status, :priority)
  end
end
