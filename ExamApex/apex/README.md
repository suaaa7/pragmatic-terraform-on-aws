## ModuleへのSymlink作成

```
$ apex infra get
```

## Lambda関数用IAM Roleの作成

```
# 確認
$ apex infra plan -target=module.iam
# 実行
$ apex infra apply -target=module.iam
```

## Lambda関数のデプロイ

```
# 確認
$ apex deploy --dry-run
# 実行
$ apex deploy
```

## 残りのTerraformを実行

```
# 確認
$ apex infra plan
# 実行
$ apex infra apply
```

## 後片付け

```
# Lambda削除
$ apex delete
# Terraformのdestroy実行
$ apex infra destroy
```
