# avi

[dviavi](https://github.com/Kiri-Nakuni/dviavi)（DVI の 1 ページを動画の 1 フレームにするツール）で動画を作るための
(u)pLaTeX のクラスとパッケージ。

| ファイル | 内容 | ドキュメント |
|---|---|---|
| `tex/avi.cls` | 紙をそのまま動画の画面にするクラス（`jsarticle` を基にする。`ver=old` で `jarticle`/`ujarticle`） | [doc/avi-class.md](doc/avi-class.md) |
| `tex/avianim.sty` | animate パッケージと同じ書き方のフレームアニメーション（TikZ などをそのまま使える） | [doc/avianim.md](doc/avianim.md) |
| `tex/avivoice.sty` | 声を文書の中で定義して、話させ・歌わせる（日本語のローマ字と英語の ARPAbet、矩形波の声） | [doc/avivoice.md](doc/avivoice.md) |

```latex
\documentclass[12pt, fps=30, size=1280x720]{avi}
\usepackage{tikz, avianim, avivoice}
\begin{document}
\begin{animateinline}{12}
  \multiframe{24}{rA=0+15}{\tikz \draw[thick] (0,0) -- (\rA:1.5);}
\end{animateinline}
\end{document}
```

## 使い方

dviavi のリポジトリ（`dviavi.tex`・`dviavi.sty` と dviavi 本体）が要る。

```sh
export TEXINPUTS=/path/to/avi/tex//:/path/to/dviavi/tex//:
uplatex foo.tex
dviavi foo.dvi
```

例: `sample/daisy/`（「デイジー・ベル」を矩形波の声で、英語とローマ字の 2 回歌う。`make` で作る）。

## テスト

```sh
make test            # dviavi のリポジトリが隣にあるとき。別の場所なら make test DVIAVI_DIR=...
```

dviavi の `tests/tex/run.py` で `tests/tex/` のテスト文書を動かす（ページ数・エラー・special・dvipdfmx との画像の比較）。

## ライセンスと謝辞

MIT ライセンス（[LICENSE](LICENSE)）。

TeX を作った Donald E. Knuth と、LaTeX を作った Leslie Lamport に感謝します。
