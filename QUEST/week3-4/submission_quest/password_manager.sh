#!/bin/zsh

INPUT_FILE="data.txt"
OUTPUT_FILE="data.gpg"
RECIPIENT="osanojunpei@gmail.com"

PasswordManager(){
read "answer?次の選択肢から入力してください:(Add Password/Get Password/Exit):"
case ${(L)answer} in
  "add password")
    AddPassword;;
  "get password")
    GetPassword;;
  "exit")
    echo "Thank you!";;
  *)
    echo "入力が間違えています。"
    PasswordManager;;
esac
}

AddPassword(){
    echo "登録するサービス名、ユーザ名、パスワードを入力してください"
    read "service_name?サービス名を入力してください:"
    read "user_name?ユーザ名を入力してください:"
    read "password?パスワードを入力してください:"
    gpg --yes --output "$INPUT_FILE" --decrypt "$OUTPUT_FILE" 2>/dev/null
    echo "$service_name:$user_name:$password" >> $INPUT_FILE
    echo "パスワードの追加は成功しました。"
    gpg --yes --encrypt --output "$OUTPUT_FILE" --recipient "$RECIPIENT" "$INPUT_FILE" 2>/dev/null
    rm $INPUT_FILE
    PasswordManager
}

GetPassword(){
    read "service_name?サービス名を教えてください:"
    gpg --yes --output "$INPUT_FILE" --decrypt "$OUTPUT_FILE" 2>/dev/null
    matched_line=$(grep -E "$service_name:.*" "$INPUT_FILE" 2>/dev/null) 
    rm $INPUT_FILE 2>/dev/null
    if [ -n "$matched_line" ]; then
      service_name=$(echo "$matched_line" | sed -E 's/(.+):.+:.+/\1/')
      user_name=$(echo "$matched_line" | sed -E 's/.+:(.+):.+/\1/')
      password=$(echo "$matched_line" | sed -E 's/.+:.+:(.+)/\1/')
      echo "サービス名:${service_name}"
      echo "ユーザ名:${user_name}"
      echo "パスワード:${password}"
    else
      echo "そのサービスは登録されていません。"
    fi
    PasswordManager
}

echo "パスワードマネージャーへようこそ!"
PasswordManager
