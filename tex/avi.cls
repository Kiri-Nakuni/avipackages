%% avi.cls -- a (u)pLaTeX class whose paper is the video screen (for dviavi)
%%
%%   \documentclass[12pt, fps=30, size=1280x720]{avi}
%%
%% Based on jsarticle (with `uplatex' under upLaTeX); `ver=old' uses
%% jarticle/ujarticle instead (the layout of the former dviavi.cls).
%% Options with a value are \dviaviSetup keys (given to the dviavi package
%% before the page layout is computed), except `ver'; the others go to the
%% base class.  The driver option `dvipdfmx' is made global, so that
%% graphicx, xcolor and PGF produce the specials dviavi understands.
\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{avi}{2026/11/23}{1.1}{video screen class for dviavi}

%% ---------------------------------------------------------------- options
\bool_new:N \l__avi_old_bool        % ver=old: jarticle / ujarticle
\clist_new:N \l__avi_class_clist    % options for the base class

\keys_define:nn { avi }
  {
    ver .choice: ,
    ver / new .code:n = { \bool_set_false:N \l__avi_old_bool } ,
    ver / old .code:n = { \bool_set_true:N \l__avi_old_bool } ,
    % key=value: a \dviaviSetup key; a bare word: a base class option
    unknown .code:n =
      {
        \tl_if_empty:nTF {#1}
          { \clist_put_right:NV \l__avi_class_clist \l_keys_key_str }
          { \PassOptionsToPackage { \l_keys_key_str = #1 } { dviavi } }
      } ,
  }

%% the driver for graphicx, xcolor and PGF, as a global option (packages that
%% read the unprocessed list, like xcolor, see it too)
\clist_gput_right:Nn \@classoptionslist { dvipdfmx }
\cs_if_exist:NT \@raw@classoptionslist
  { \clist_gput_right:Nn \@raw@classoptionslist { dvipdfmx } }

\ProcessKeyOptions [ avi ]

%% ---------------------------------------------------------------- base class
%% upLaTeX declares the JY2 encoding, pLaTeX JY1 (both may run on e-upTeX,
%% so the engine cannot tell them apart)
\bool_new:N \l__avi_up_bool
\cs_if_exist:cT { T@JY2 } { \bool_set_true:N \l__avi_up_bool }

\tl_new:N \l__avi_base_tl
\bool_if:NTF \l__avi_old_bool
  { \tl_set:Ne \l__avi_base_tl { \bool_if:NT \l__avi_up_bool { u } jarticle } }
  {
    \tl_set:Nn \l__avi_base_tl { jsarticle }
    \bool_if:NT \l__avi_up_bool { \clist_put_left:Nn \l__avi_class_clist { uplatex } }
  }
\use:e
  {
    \exp_not:N \LoadClass
      [ \clist_use:Nn \l__avi_class_clist { , } ] { \l__avi_base_tl }
  }
\RequirePackage { dviavi }

%% ---------------------------------------------------------------- the screen
%% jsarticle makes sizes other than 10pt by \mag: give the paper back its
%% true size, so that only the type gets bigger
\int_compare:nNnF { \tex_mag:D } = { 1000 }
  {
    \dim_set:Nn \paperwidth { \paperwidth * 1000 / \tex_mag:D }
    \dim_set:Nn \paperheight { \paperheight * 1000 / \tex_mag:D }
  }

%% ordinary pages: the paper's top-left corner is the origin, with a 1cm
%% margin on the screen and no head, foot or page number
\pagestyle { empty }
\dim_set:Nn \parindent { 0pt }
\dim_set:Nn \hoffset { -1truein }
\dim_set:Nn \voffset { -1truein }
\dim_set:Nn \oddsidemargin { 1truecm }
\dim_set:Nn \evensidemargin { 1truecm }
\dim_set:Nn \topmargin { 1truecm }
\dim_set:Nn \headheight { 0pt }
\dim_set:Nn \headsep { 0pt }
\dim_set:Nn \footskip { 0pt }
\dim_set:Nn \textwidth { \paperwidth - 2truecm }
\dim_set:Nn \textheight { \paperheight - 2truecm }
