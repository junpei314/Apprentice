'use strict';

const addTask = () => {
  const todoList = document.getElementById('todo-list');
  const todoInput = document.getElementById('todo-input');
  const htmlContent = `<li class="todo-item"><input type="checkbox" onclick="checkBox(event)"><span>${todoInput.value}</span><button class="delete-button" onclick="deleteTask(event)">削除</button></li>`;
  todoList.insertAdjacentHTML('beforeend', htmlContent);
  todoInput.value = '';
};

const deleteTask = (event) => {
  event.target.parentElement.remove();
};

const checkBox = (event) => {
  if (event.target.checked === true) {
    event.target.nextElementSibling.style.textDecoration = "line-through";
  } else {
    event.target.nextElementSibling.style.textDecoration = "none";
  }
};

const addButton = document.getElementById('add-button');
addButton.addEventListener('click', addTask);


