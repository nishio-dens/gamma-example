# Gamma Example

gamma の使い方を紹介する サンプルプログラムです。


# Setup

```
bundle install

./setup.sh
```

その後、

- database\_production.yml 
- database\_development.yml 
- settings.yml

を編集後、以下を実行しデータを投入してください。

```
bundle exec ruby ./setup_data.rb
```

# Gammaでデータ同期

## テーブルを全て同期する


Dryrun でどんな感じにデータが同期されるか確認します。

```
bundle exec gamma dryrun --settings settings.yml --data gamma_data/pattern1.yml
```

問題なければ同期を実行します。

```
bundle exec gamma apply --settings settings.yml --data gamma_data/pattern1.yml
```


## テーブルを同期する際にHookをかける

```
bundle exec gamma dryrun --settings settings.yml --data gamma_data/pattern2.yml
bundle exec gamma apply --settings settings.yml --data gamma_data/pattern2.yml
```

