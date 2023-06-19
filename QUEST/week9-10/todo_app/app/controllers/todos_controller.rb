class TodosController < ApplicationController
  def create
    @todos = Todo.new(todo_params)
    @todos.save
    redirect_to "http://localhost:3000"
  end

  def edit
    @todo = Todo.find(params[:id])
    @placeholder = @todo.title
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(title: todo_params[:title])
    redirect_to "http://localhost:3000"
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to "http://localhost:3000"
  end

  def todo_params
    params.require(:todo).permit(:title)
  end
end
