# avianim.sty リファレンス

animate パッケージと同じ書き方で、フレームアニメーションを dviavi の動画にするパッケージ。
TikZ などの絵をそのまま使える（avi クラスなら PGF は dvipdfmx ドライバになり、dviavi がその描画を解釈する）。

```latex
\documentclass{avi}
\usepackage{tikz,avianim}
\begin{document}
\begin{animateinline}[begin={\begin{tikzpicture}\useasboundingbox (-3,-2) rectangle (3,2);},
                      end={\end{tikzpicture}}]{12}
  \node {start};
\newframe[24]
  \multiframe{24}{rA=0+15, iB=1+1}{\draw[thick,blue] (0,0) -- (\rA:1.5); \node at (0,-1.5) {\iB};}
\end{animateinline}
\end{document}
```

## 動き方

- アニメーションの 1 フレームは 1 回だけ組まれ、`\dviaviLayout`（既定は中央）で画面全体のフレームになる。
- 表示する長さはフレームレートから決まる。動画のフレームレート（`fps`）に合わせて何フレーム見せるかを、
  累積時間を丸めて決める（12 fps のアニメーションを 24000/1001 の動画にすると、1 フレームがほぼ 2 フレームになり、合計時間はずれない）。
  動画 1 フレームより短いフレームは表示されない（組まれるので、カウンタなどは進む）。
- 音の命令（`\speak`、`\sing`、`\dviaviMark` など）はフレームの中に書ける。そのフレームを表示する最初の動画フレームでだけ働く
  （表示されない短いフレームのものは、次に表示されるフレームに付く）。
- フレームレートが 0 以下ならエラーにして、動画のフレームレートを使う。

## コマンド

| animate と同じもの | 内容 |
|---|---|
| `\begin{animateinline}[オプション]{フレームレート} … \end{animateinline}` | アニメーション（`avianim` 環境も同じ） |
| `\newframe[フレームレート]` | 次のフレームへ。`[ ]` でここからのフレームレートを変える（`\newframe*` も `\newframe` と同じ） |
| `\multiframe{枚数}{変数=初期値+増分, …}{内容}` | 内容を枚数ぶん組む。変数の型は名前の頭文字: `i` 整数、`n` `r` `R` 実数、`d` 寸法 |
| `\animategraphics[オプション]{フレームレート}{ファイル名の頭}{最初}{最後}` | 連番画像（`frame001` のように 0 で埋めた番号は桁数を保つ） |

| オプション | 内容 |
|---|---|
| `begin={…}`, `end={…}` | 各フレームの前後に入れるコード（`\begin{tikzpicture}` … `\end{tikzpicture}` など） |
| `width=…`, `height=…`, `scale=…` | フレームを拡大縮小する（graphicx の `\resizebox`・`\scalebox`） |
| `controls`, `loop`, `autoplay`, `poster`, `timeline` など | 動画には意味がないので無視する |

`\multiframe` は、`\newframe` で区切られた部分にそれだけを書く（その部分の全部がフレームの列になる）。
ほかの内容と一緒に書くとエラーにして無視する。

animateinline の外に書いた `\multiframe` は、それだけで 1 つのアニメーションになる。フレームレートは動画と同じ
（1 フレームが動画の 1 フレーム。`\multiframe{300}{…}{…}` は 300 フレーム）。animate パッケージにはない使い方。

## テスト

`tests/tex/avianim/` のテスト文書を `python3 tests/tex/run.py avianim` で確かめる（`cargo build --release` の後）。
各文書の `%!` 行に、ページ数・エラーの数・ログの文字列・special の数・dvipdfmx との画像の比較を書く。
