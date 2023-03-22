class TasksController < ApplicationController
    #GET/tasks
    def index
        render json: Task.all, status::ok
    #GET/tasks/{id}
    def show
        task = Task.find_by(id:params[:id])
    if task
        render json: task, status::ok
    else
        render json: {error: 'Task not found'}, status: :not_found
    end
end
    # POST/tasks
    def create
        task = Task.create(task_params)
        if task.valid?
            render json: task, status: accepted
        else
            render json: {errors: "An error occured. Please try again"}
        end
    end
    # PUT/PATCH/tasks{id}
    def update
        task.update(task_params)
    if task
        render json: task, status::ok
    else
        render json: {error: 'Task not found'}, status: :not_found
    end
end
    # DELETE/tasks/id
    def destroy
        #check whether the task exists
        task = Task.find_by(id:params[:id])
        #delete the task
        if task
            task.destroy
            head:no_content
        else
            render json: {error: 'Task not found'}, status: not_found
        end
    end
    private
    def task_params
        params.permit(
            :task_name, :task_description, :task_status, :user_id, presence: true
        )
end