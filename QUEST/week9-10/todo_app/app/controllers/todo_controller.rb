class TodoController < ApplicationController
  def index
    @todos = Todo.all
  end

  def new
    @todos = Todo.new
    @placeholder = "タスクを入力する"
  end

  def create
  end
end
