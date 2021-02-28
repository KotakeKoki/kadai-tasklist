class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]
before_action :require_user_logged_in, only: [:index, :show, :edit, :new, :create]

def index
    @tasks = current_user.tasks.all
end

def show
end

def new
    @task = Task.new
end

def create
    @task = current_user.tasks.build(task_params)
    @task.user_id = current_user.id
    if @task.save
        flash[:success] = "保存に成功しました"
        redirect_to @task
    else
        flash[:danger] = "保存に失敗しました"
        render :new
    end
end

def edit
end

def update
    if @task.update(task_params)
        flash[:success] = "編集に成功しました"
        redirect_to @task
    else
        flash[:danger] = "編集に失敗しました"
        render :edit
    end
end

def destroy
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
end

private

def set_task
     @task = Task.find(params[:id])
end
 
def task_params
    params.require(:task).permit(:content, :status, :user_id)
end

end
