class TasksController < ApplicationController
  def index
    @tasks = Task.all
    if params[:search].present?
      if params[:search][:name_search].present? && params[:search][:status_search].present?
        @tasks = @tasks.name_like(params[:search][:name_search]).status_search(params[:search][:status_search])
      elsif params[:search][:name_search].present?
        @tasks = @tasks.name_like(params[:search][:name_search])
      elsif params[:search][:status_search].present?
        @tasks = @tasks.status_search(params[:search][:status_search])
      end
    elsif params[:sort].present?
      @tasks = @tasks.order(params[:sort])
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
