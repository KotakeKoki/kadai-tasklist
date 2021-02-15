class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]

def index
    @tasks = Task.all
end

def show
   set_task
end

def new
    @task = Task.new
end

def create
    @task = Task.new(task_params)
    if @task.save
        flash[:success] = "保存に成功しました"
        redirect_to @task
    else
        flash[:danger] = "保存に失敗しました"
        render :new
    end
end

def edit
   set_task
end

def update
    set_task
    if @task.update(task_params)
        flash[:success] = "編集に成功しました"
        redirect_to @task
    else
        flash[:danger] = "編集に失敗しました"
        render :edit
    end
end

def destroy
    set_task
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
end

private

def set_task
     @task = Task.find(params[:id])
 end
 
def task_params
    params.require(:task).permit(:content, :status)
end

end
