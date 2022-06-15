class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def new
    # タスクモデルのインスタンスをnewメソッドでつくり、インスタンス変数に入れる
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      # バリデーションエラーの場合、ステータスコード422を返す
      render 'new', status: :unprocessable_entity
    end
  end
  
  # これより以下は、プライベートメソッドとして扱う
  private
  def task_params
    params.require(:task).permit(:title)
  end
end
