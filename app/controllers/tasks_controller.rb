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
  # todo新規作成
  def edit 
    # p params[:id]
    @task = Task.find(params[:id])
  end
  # 更新処理
  def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to root_path
      else
        render 'edit', status: :unprocessable_entity 
      end
  end
  # 削除処理
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path, status: :see_other
  end
  
  def toggle
    @task = Task.find(params[:id])
    # 現在のデータベースに保存されているcompletedの値を反転してデータベースの値を更新
    @task.update(completed: !@task.completed)
    render turbo_stream: turbo_stream.replace(
      # taskオブジェクト自動生成するDOMID
      @task,
      # 置き換えに指定するpartialを指定
      partial: 'completed',
      # partialに渡すパラメータを指定
      locals: {task: @task}
      ) 
  end
  
  # これより以下は、プライベートメソッドとして扱う
  private
  def task_params
    params.require(:task).permit(:title)
  end
end

