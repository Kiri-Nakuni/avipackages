# avi.cls リファレンス

紙をそのまま動画の画面にする (u)pLaTeX のクラス。dviavi パッケージ（`dviavi.sty`）を読み込み、
画面の大きさの紙に動画用の版面を作る。マクロの詳細は [dviavi.md](https://github.com/Kiri-Nakuni/dviavi/blob/main/doc/dviavi.md)。

```latex
\documentclass[12pt, fps=30, size=1280x720]{avi}
\usepackage{xcolor}          % ドライバ指定は不要（dvipdfmx になる）
\begin{document}
\pagecolor{black}\color{white}
\dviaviFrames{48}{\Huge フレーム \the\dviaviframe}
\end{document}
```

```sh
uplatex video        # platex でもよい
dviavi video         # → video.avi
```

## 基にするクラス

| 指定 | pLaTeX（`platex`） | upLaTeX（`uplatex`） |
|---|---|---|
| 既定 | `jsarticle` | `jsarticle`（`uplatex` オプション付き） |
| `ver=old` | `jarticle` | `ujarticle` |

`ver=old` は以前の `dviavi.cls` と同じ版面になる（`dviavi.cls` は `avi.cls` に置き換わった）。

pLaTeX と upLaTeX のどちらかは、和文の符号化 `JY2`（upLaTeX）が宣言されているかで判断する
（TeX Live 2023 以降の `platex` は e-upTeX の上で動くので、エンジンの命令では区別できない）。

## オプション

| 書き方 | 行き先 | 例 |
|---|---|---|
| `ver=old` / `ver=new` | このクラス | 基にするクラスを `jarticle`/`ujarticle` にする / `jsarticle` にする（既定）。ほかの値はエラー |
| その他の `key=value` | dviavi パッケージ（`\dviaviSetup` のキー） | `fps=30`, `size=1280x720`, `rate=44100`, `keyint=120`, `mix=sound.mix`, `paperwidth=192mm`, `paperheight=108mm` |
| 値のないもの | 基にするクラス | `10pt`, `12pt`, `20pt` など |

- `key=value` のオプションは版面を計算する前に dviavi パッケージに渡る。`paperwidth`/`paperheight` を変えると、
  通常のページの版面もその紙に合わせて決まる。
- **ドライバ**: クラスが `dvipdfmx` をグローバルオプションに加えるので、graphicx・xcolor・PGF/TikZ は
  自動的に dvipdfmx 用の special を出す（dviavi が解釈するのはこの形式）。ドライバを指定しなくてよい。
- 各キーの意味と既定値は [dviavi.md の「形式」](https://github.com/Kiri-Nakuni/dviavi/blob/main/doc/dviavi.md#形式)。既定の紙は 160mm × 90mm、画面は 1920×1080、
  フレームレートは 24000/1001。

## 文字の大きさと \mag

`jsarticle` は 10pt 以外の大きさを `\mag` で作る（12pt なら `\mag=1200`、全体を 1.2 倍）。
avi クラスは紙の大きさを true 単位に直すので、`12pt` でも画面（紙）の大きさは変わらず、文字だけが大きくなる。
dviavi は DVI の拡大率を読んで描くので、そのまま正しい大きさで出力される。

## 版面

| 設定 | 値 |
|---|---|
| `\paperwidth` × `\paperheight` | `paperwidth` × `paperheight`（既定 160mm × 90mm、true 単位） |
| `\hoffset`, `\voffset` | `-1truein`（紙の左上を原点にする） |
| `\oddsidemargin`, `\evensidemargin`, `\topmargin` | `1truecm` |
| `\headheight`, `\headsep`, `\footskip` | `0pt` |
| `\textwidth` | `\paperwidth - 2truecm` |
| `\textheight` | `\paperheight - 2truecm` |
| `\pagestyle` | `empty`（ノンブルなし） |
| `\parindent` | `0pt` |

この版面は、LaTeX の通常の出力ルーチンでページを作る場合（本文をそのまま書いた場合）に使われる。
`\dviaviFrame`, `\dviaviFrames`, `\dviaviStill` で作るフレームは版面と関係なく、紙全体に `\dviaviLayout` で置かれる
（既定は中央。`\hoffset`, `\voffset` の値にもよらない）。

通常のページも 1 ページが 1 フレームになる。長く見せたいページは `\dviaviStill{n}{…}` で作る。

## 使い分け

| やりたいこと | 書き方 |
|---|---|
| 画面の大きさの紙で、動画のためだけの文書を書く | `\documentclass{avi}` |
| 以前の `dviavi.cls` の版面のまま | `\documentclass[ver=old]{avi}` |
| 別のクラス（`jlreq` など）の組版を動画にする | そのクラス + `\usepackage{dviavi}`。ドライバ（`dvipdfmx`）と、紙と画面の縦横比は自分で合わせる |
| plain TeX | `\input dviavi`（e-pTeX / e-upTeX） |

## 注意

- e-TeX 拡張が要る（`platex`, `uplatex` は満たしている）。
- オプションは l3keys（`\ProcessKeyOptions`）で処理するので、LaTeX 2022-06 以降が要る。
- `\pagecolor` は背景色、`\color` はフレームの文字色として引き継がれる。
- graphicx・PGF の描画がどこまで出るかは [dviavi.md の「dvipdfmx の special」](https://github.com/Kiri-Nakuni/dviavi/blob/main/doc/dviavi.md#dvipdfmx-の-special) を参照。
