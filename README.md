QBCore 木こりジョブスクリプト
このリポジトリでは、QBCoreフレームワークを使用した木こりジョブのスクリプトを提供します。プレイヤーが木を切り、その木材をNPCに売却することで収入を得ることができます。ox_targetを利用して、木を切るインタラクションや売却を簡単に行えるようになっています。

特徴
木のスポーンとインタラクション: マップ上に木をスポーンし、プレイヤーは特定の場所で木を切ることができます。
木を切るアクション: プレイヤーは指定の木を選び、木を切って木材や樹皮などのアイテムを獲得します。
NPCでのアイテム売却: プレイヤーは取得したアイテムを売却し、報酬としてお金を得ることができます。
簡単な設定: スクリプト内で、木の座標や売却価格などを自由にカスタマイズできます。
インストール方法
このリポジトリをクローンまたはダウンロードします。


git clone https://github.com/yourusername/lumberjack-job.git
lumberjack-jobフォルダを[qb]ディレクトリ内に配置します。

依存関係:

qb-core
ox_target
これらのリソースがまだインストールされていない場合、ダウンロードしてサーバーに追加してください。

server.cfgの編集: server.cfgに以下の行を追加し、リソースを起動します。

ruby
コードをコピーする
ensure lumberjack-job
アイテムの追加: qb-core/shared/items.luaに以下のアイテムを追加してください。


['wood'] = {['name'] = 'wood', ['label'] = '木材', ['weight'] = 100, ['type'] = 'item', ['image'] = 'wood.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '切り出された木材'},
['bark'] = {['name'] = 'bark', ['label'] = '樹皮', ['weight'] = 50, ['type'] = 'item', ['image'] = 'bark.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '木から採れた樹皮'}
ox_inventoryも同じように追加してください
そのうち追加する


使用方法
木を切る
マップ上で指定された木に近づくと、ox_targetを使って木を選択し、インタラクションが可能になります。
"木を切る"オプションを選択すると、プレイヤーが木を切るアクションを実行し、指定されたアイテム（woodやbark）を入手します。
アイテムの売却
設定された売却NPCの元へ行き、ox_targetを使って"木材を売る"オプションを選択します。
持っているアイテムに応じて、お金が支払われます。
設定
Config.luaのカスタマイズ
木の座標やモデル: Config.Treesで木がスポーンする場所やモデルを設定できます。
クールダウン時間: 同じ木を再び切るまでの時間をcooldownで設定可能です（秒単位）。
得られるアイテム: Config.ChoppedItemsで、木を切った際に取得できるアイテムとその数量を変更できます。
売却価格: Config.WoodPriceとConfig.BarkPriceで、木材や樹皮の売却単価を調整できます。
必要条件
QBCore Framework: https://github.com/qbcore-framework
ox_target: https://github.com/overextended/ox_target
ライセンス
このプロジェクトはMITライセンスのもとで提供されています。