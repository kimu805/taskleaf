class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :confirm_edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.recent
  end

  def new
    @task = current_user.tasks.new
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      redirect_to root_path, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def confirm_edit
    @task.attributes = task_params
    render :edit unless @task.valid?
  end

  def update
    @task.attributes = task_params
    if params[:back].present?
      render :edit
      return
    end

    if @task.update(task_params)
      redirect_to root_path, notice: "タスク「#{@task.name}」を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
