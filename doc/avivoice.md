# avivoice.sty リファレンス

声を文書の中で定義して、話させ・歌わせるパッケージ。dviavi.sty の `\speak` の上位版で、
英語（ARPAbet）・矩形波の声（`engine=square`）・歌（MML）を TeX から扱える。

```latex
\documentclass{avi}
\usepackage{avivoice}
\avivoiceDefine{daisy}{engine=square, lang=en, vib={5Hz,6c}}
\avivoicePhoneme[daisy]{k}{noise=-3dB, dur=25ms}
\avivoiceSetup{ch=daisy}
\begin{document}
\dviaviStill{48}{\avivoiceSpeak{D.EY Z.IY / D.EY Z.IY}}
\dviaviStill{96}{\avivoiceSing{t150 l4 q8 "D.EY Z.IY D.EY Z.IY" o4 d2. o3 b2. g2. d2.}}
\dviaviStill{48}{\avivoiceSpeak[lang=ja]{KoNnNiChiWa}}
\end{document}
```

例: `sample/daisy/`（「デイジー・ベル」を矩形波の声で英語とローマ字の 2 回歌う）。

## 声と音素

| コマンド | 内容 |
|---|---|
| `\avivoiceDefine{名前}{キー=値, …}` | 声を定義する。キーは sound.mix の `voice` と同じ（`f0` `mora` `formant` `breath` `gain` `vib` `engine` `lang`） |
| `\avivoicePhoneme[声]{音素}{キー=値, …}` | 音素を調整する。キーは sound.mix の `phoneme` と同じ。`[声]` を省くと全部の声 |

- 定義は sound.mix の文として dviavi に渡す（`mixdef` special）。sound.mix がなくてもよく、
  同じ名前の sound.mix の定義より優先する（声の定義は丸ごと置き換わる）。
- コンマを含む値は `{}` で囲む: `vib={5Hz,6c}`、`f={850,1250,2600}`。
- どこに書いてもよい（プリアンブルやフレームの間なら次のフレームに付く）。

## 話す・歌う

| コマンド | 内容 |
|---|---|
| `\avivoiceSpeak[キー]{テキスト}` | 話す |
| `\avivoiceSing[キー]{MML}` | 歌う（歌詞は MML の中の `"…"`） |
| `\speak{キー}` / `\sing{キー}` | 同じもの（テキストは `text=`、MML は `mml=`）。`\speak` は dviavi.sty のものを置き換える |
| `\avivoiceSetup{キー}` | 既定値を変える（グループの中ならそこだけ） |

| キー | 既定値 | 内容 |
|---|---|---|
| `ch` | `default` | 声 |
| `lang` | 声の `lang` | `ja`（ローマ字、大文字がモーラの先頭）か `en`（ARPAbet の音節を空白で区切る） |
| `tone`, `speed`, `pace` | `normal`, `1`, `1` | `\speak` と同じ（[dviavi.md](https://github.com/Kiri-Nakuni/dviavi/blob/main/doc/dviavi.md#音)） |
| `gain` | `1` | 歌の音量（`0.5`、`-6dB`） |
| `text` / `mml` | | 話す内容 / 歌う MML |

- 音はそのフレームの時刻に始まる（`\dviaviFrames` の繰り返しでは最初の 1 枚だけ）。歌の最初の子音はその少し前から鳴る。
- 値の空白はそのまま残る（英語のテキストや MML に使える）。MML の書き方は [sound-mix.md](https://github.com/Kiri-Nakuni/dviavi/blob/main/doc/sound-mix.md#mml)、
  英語の音素は [sound-mix.md](https://github.com/Kiri-Nakuni/dviavi/blob/main/doc/sound-mix.md#音素とモーラ)。
- 英語の `text` でも `/`（句の区切り）と `_`（休み）が使える。1 音節が `mora`（`pace`）1 つ分の長さになる。

| 書き方 | 例 |
|---|---|
| 日本語（`lang=ja`） | `"KoNnNiChiWa"`（1 モーラ 1 音符）、`"DeI\|Ji-"`（`\|` ごとに 1 音符） |
| 英語（`lang=en`） | `"D.EY Z.IY"`（1 音節 1 音符）、`"S.W.IY.T"`（オンセット・核・コーダ） |
