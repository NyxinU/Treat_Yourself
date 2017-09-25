class Api::TasksController < ApplicationController
  def index
    @tasks = Task.all
    render :index
  end

  def show
    @task = Task.find(params[:id])

    if @task
      render :show
    else
      render json: ['This task does not exist'], status: 404
    end
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render :show
    else
      render json: @task.errors.full_messages, status: 422
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      render :show
    else
      render json: @task.errors.full_messages, status: 422
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task
      @task.destroy
      render :show
    else
      render json: ["Task does not exist"], status: 404
    end
  end



  private

  def task_params
    params.require(:task).permit(:title, :list_id, :due, :reward, :completed, :user_id)
  end

end
