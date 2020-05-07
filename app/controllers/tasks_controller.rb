class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 5

  def index
    @tasks = current_user.tasks
    if params[:search].present?
      @tasks = @tasks.name_like(params[:name_search])
                 .status_search(params[:status_search])
                 .label_search(params[:label_search])
    end
    if params[:sort].present?
      @tasks = @tasks.order("#{params[:column]} #{params[:sort]}")
    else
      @tasks = @tasks.recent
    end
    @tasks = @tasks.page(params[:page]).per(PER)
    change_layout
  end
  
  def new
    @task = current_user.tasks.build
    @labels = Label.select(:id, :name)
    change_layout
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_url, success: "タスク「#{@task.name}」を登録しました"
    else
      change_layout_render(:new)
    end
  end

  def show
    change_layout
  end

  def edit
    @labels = Label.select(:id, :name)
    change_layout
  end

  def update
    if @task.update(task_params)
      redirect_to task_url, success: "タスク「#{@task.name}」を更新しました。"
    else
      change_layout_render(:edit)
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, success: "タスク「#{@task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :content, :end_deadline, :status, :priority, { label_ids: []})
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def change_layout
    render layout: 'admin_application' if current_user.admin?
  end

  def change_layout_render(action)
    current_user.admin? ? (render action, layout: 'admin_application') : (render action)
  end
end
