#!/bin/bash

cp database_production.{yml.example,yml}
echo "database_production.yml を編集してください。"

cp database_development.{yml.example,yml}
echo "database_development.yml を編集してください。"


cp settings.{yml.example,yml}
echo "settings.yml は gamma のDB設定ファイルです。DBの設定を編集してください。"
