"use strict";

const books = [
  {
    name :"『JavaScript入門』",
    author : "山田太郎"
  },
  {
    name : "『JavaScriptの絵本』",
    author : "山田次郎"
  }
]

const printBooks = books => {
  books.forEach(book  => {
    return console.log(book.name + book.author);
  });
};

printBooks(books);

let users = [
  {
    username: '山田',
    permissions: {
      canRead: true,
      canWrite: true,
      canDelete: false
    }
  },
  {
    username: '佐藤',
    permissions: {
      canRead: false,
      canWrite: true,
      canDelete: false
    }
  },
  {
    username: '小佐野',
    permissions: {
      canRead: true,
      canWrite: false,
      canDelete: false
    }
  }
];

const checkPermission = (name, permission) => {
  users.forEach((user) => {
    if (user.username === name) {
      if (user.permissions[permission] === true) {
        console.log(true);
      }
    }
  });
};


checkPermission('小佐野', 'canRead');

const obj = {
  method: function() {
    console.log('method');
  },
}

obj.method();