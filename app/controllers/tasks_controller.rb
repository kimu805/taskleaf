class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime("%Y%m%d%S")}.csv" }
    end
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to root_path, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
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
    head :no_content
  end

  def import
    if params[:file] == nil
      flash.notice = "CSVファイルを選択してください"
      return
    end
    current_user.tasks.import(params[:file])
    redirect_to root_path, notice: "タスクを追加しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
