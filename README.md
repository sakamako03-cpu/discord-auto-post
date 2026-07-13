# Discordへの「7つの習慣」毎日自動投稿

GitHub Actionsを使い、毎朝9時頃（JST）にDiscordの指定チャンネルへ「7つの習慣」振り返りメッセージを自動投稿します。

- 月〜日で第1〜第7の習慣を1つずつ紹介
- 各曜日ごとに4パターンの文面を用意し、4週間（約1ヶ月）は同じ文面が繰り返されないようローテーション
- Webhook URLはGitHubの「Secrets」に保存するため、コード上には一切残りません

## セットアップ手順（3ステップ）

### 1. GitHubに新しいリポジトリを作成する

https://github.com/new で新規リポジトリを作成してください（Private推奨）。「Add a README」等のチェックは外してOKです。

### 2. このフォルダの中身をアップロードする

ターミナルでこのフォルダに移動し、以下を実行してください（`<あなたのリポジトリURL>`は作成したリポジトリのURLに置き換えてください）。

```bash
cd "discord-auto-post"
git remote add origin <あなたのリポジトリURL>
git branch -M main
git push -u origin main
```

### 3. DiscordのWebhook URLをGitHub Secretsに登録する

1. GitHub上のリポジトリページで「Settings」→「Secrets and variables」→「Actions」を開く
2. 「New repository secret」をクリック
3. Name: `DISCORD_WEBHOOK_URL`
4. Secret: Discordで発行したWebhook URLを貼り付ける
5. 「Add secret」で保存

以上で設定完了です。毎日午前9時頃（JST）に自動投稿が始まります。

## 動作確認したい場合

GitHubリポジトリの「Actions」タブ →「Discord Daily Post」→「Run workflow」で、スケジュールを待たずに今すぐ1回テスト投稿できます。

## 文面を変更・追加したい場合

`content.json` を編集してください。曜日ごと（1=月曜〜7=日曜）に4パターンの配列が入っています。編集後は以下でGitHubに反映してください。

```bash
git add content.json
git commit -m "文面を更新"
git push
```
