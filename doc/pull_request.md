
## gitの使い方
### gitの使い方について
* ファイルの追加  
git add \_file\_name\_
* ファイルの保存  
git commit -m '\_commit\_message\_'
* リモートへのファイルのアップロード
git push \_remote\_repository\_ \_remote\_branch\_
* リモートからファイルを落としてくる
git pull \_remote\_repository\_ \_remote\_branch\_

### remoteリポジトリ
* heroku : herokuのリポジトリ(Bot 開発用)  
<https://git.heroku.com/cyber-agent-line.git>
* origin : githuのリポジトリ(ソースコード管理用)  
<https://github.com/Rp7rf/team_c>


## git での合わせ方

branch の作成

	$ git checkout -b feature/_name_
	$ cp ../heroku/_file_ . 

add & commit

	$ git push -u origin feature/_name_
	
ブラウザからプルリクエストを送ります