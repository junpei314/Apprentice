"use strict";

const title = document.getElementsByTagName('h1');
title.item(0).textContent = 'シンプルブログ';

// const show_title_content = () => {
//   const title1 = document.getElementById('title');
//   console.log(title1.getAttribute('value'));
//   const content = document.getElementById('content');
//   console.log(content.textContent);
// };

  let i = 0;

function showTitleContent(){
  const title1 = document.getElementById('title');
  const content = document.getElementById('content');
  const posts = document.getElementById('posts');
  const h2 = document.createElement('h2');
  h2.textContent = title1.value;
  posts.appendChild(h2);
  const p = document.createElement('p');
  p.textContent = content.value;
  posts.appendChild(p);
  title1.value = '';
  content.value = '';
  i++;
  if(i > 3) {
    posts.firstElementChild.remove();
    posts.firstElementChild.remove();
    i--;
  }
};

function changeBgColor() {
  post_form.style.backgroundColor = 'yellow';
};

function restoreBgColor() {
  post_form.style.backgroundColor = 'white';
};

const submit = document.getElementById('submit');
submit.addEventListener('click', showTitleContent);
const post_form = document.getElementById('post-form');
post_form.addEventListener('mouseover', changeBgColor);
post_form.addEventListener('mouseout', restoreBgColor);
