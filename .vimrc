set sw=4
set ts=4
set et
set smarttab
set smartindent
set lbr
set fo+=mB
set sm
set selection=inclusive
set wildmenu
set mousemodel=popup

au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict

"
"syntastic相关
execute pathogen#infect()
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
"golang
"Processing... % (ctrl+c to stop)
let g:fencview_autodetect=0
set rtp+=$GOROOT/misc/vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set cul "高亮光标所在行
set cuc
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
set go=             " 不要图形按钮  
"color desert     " 设置背景主题  
color ron     " 设置背景主题  
"color torte     " 设置背景主题  
"set guifont=Courier_New:h10:cANSI   " 设置字体  
"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
"set foldenable      " 允许折叠  
""set foldmethod=manual   " 手动折叠  
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 使用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
" 历史记录数
set history=1000
"搜索逐字符高亮
set hlsearch
set incsearch
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 总是显示状态行
set cmdheight=2
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目

"markdown配置
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript
"rkdown to HTML  
nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
nmap fi :!firefox %.html & <CR><CR>
nmap \ \cc
vmap \ \cc

"将tab替换为空格
nmap tt :%s/\t/    /g<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
	    call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: ") 
		call append(line(".")+2, "	> Mail: ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
	"新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:nmap <silent> <F9> <ESC>:Tlist<RETURN>
" shift tab pages
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
map! <C-Z> <Esc>zzi
map! <C-O> <C-Y>,
map <C-A> ggVG$"+y
map <Esc><Esc> :w<CR>
map <F12> gg=G
map <C-w> <C-w>w
imap <C-k> <C-y>,
imap <C-t> <C-q><TAB>
imap <C-j> <ESC>
" 选中状态下 Ctrl+c 复制
"map <C-v> "*pa
imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$
vmap <C-c> "+y
set mouse=v
"set clipboard=unnamed
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 
"nnoremap <Leader>fu :CtrlPFunky<Cr>
"nnoremap <C-n> :CtrlPFunky<Cr>
"列出当前目录文件  
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"打开树状文件目录  
map <C-F3> \be  
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -std=c++11 -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -std=c++11 -g -o %<"
	exec "!gdb ./%<"
endfunc


"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全 
set completeopt=preview,menu 
"允许插件  
"filetype plugin on
"共享剪贴板  
"set clipboard+=unnamed 
"自动保存
set autowrite
"set ruler                   " 打开状态栏标尺
"set cursorline              " 突出显示当前行
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
""set foldcolumn=0
""set foldmethod=indent 
""set foldlevel=3 
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase




set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
"自动补全
"":inoremap ( ()<ESC>i
"":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
"":inoremap [ []<ESC>i
"":inoremap ] <c-r>=ClosePair(']')<CR>
"":inoremap " ""<ESC>i
"":inoremap ' ''<ESC>i
""function! ClosePair(char)
""	if getline('.')[col('.') - 1] == a:char
""		return "\<Right>"
""	else
""		return a:char
""	endif
""endfunction
filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Sort_Type = "name"    " 按照名称排序  
let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
""let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
""let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的
"设置tags  
set tags=tags;  
set autochdir 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"其他东东
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"默认打开Taglist 
let Tlist_Auto_Open=0 
"""""""""""""""""""""""""""""" 
" Tag list (ctags) 
"""""""""""""""""""""""""""""""" 
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags' 
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1  
nmap tl :Tlist<cr>

"python补全
let g:pydiction_location = '~/.vim/after/complete-dict'
let g:pydiction_menu_height = 20
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1


set iskeyword+=.
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

autocmd FileType python set omnifunc=pythoncomplete#Complete

"set nocompatible               " be iMproved
"filetype off                   " required!

call plug#begin('~/.vim/bundle')

" let Vundle manage Vundle
" required! 
Plug 'gmarik/vundle',{'for':'clojure'}

" My Bundles here:
"
" original repos on github
Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'Yggdroot/indentLine'
"ndle 'tpope/vim-rails.git'
" vim-scripts repos
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'
" non github repos
" python_yvFaGaoLiang
"Plug 'wincent/command-t'
Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/Auto-Pairs'
Plug 'vim-scripts/python-imports.vim',{'for':'py'}
Plug 'vim-scripts/CaptureClipboard'
Plug 'vim-scripts/ctrlp-modified.vim'
Plug 'vim-scripts/last_edit_marker.vim'
Plug 'vim-scripts/synmark.vim'
"Bundle 'Python-mode-klen'
Plug 'vim-scripts/SQLComplete.vim',{'for':'sql'}
Plug 'vim-scripts/Javascript-OmniCompletion-with-YUI-and-j',{'for':'js'}
"Bundle 'JavaScript-Indent'
"Bundle 'Better-Javascript-Indentation'
Plug 'vim-scripts/jslint.vim'
Plug 'pangloss/vim-javascript',{'for':'js'}
Plug 'vim-scripts/Vim-Script-Updater'
Plug 'vim-scripts/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'vim-scripts/jsbeautify'
Plug 'vim-scripts/The-NERD-Commenter'
"django
Plug 'vim-scripts/django_templates.vim'
Plug 'vim-scripts/Django-Projects'
"ale
Plug 'w0rp/ale'
"PeiSe
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'fatih/molokai'
Plug 'morhetz/gruvbox'
"zhuang_tai
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"对齐线插件"
Plug 'nathanaelkane/vim-indent-guides'
"搜索插件"
Plug 'vim-scripts/EasyGrep'
"注译插件"
Plug 'scrooloose/nerdcommenter'
"记录历史"
Plug 'mbbill/undotree'
"go
Plug 'fatih/vim-go',{'for':'go'}
"Tagbar
Plug 'majutsushi/tagbar'
"c/c++
Plug 'hdima/python-syntax',{'for':'py'}
Plug 'Valloric/YouCompleteMe'
"erlang
Plug 'jimenezrick/vimerl'
call plug#end()
"Bundle 'FredKSchott/CoVim'
"Bundle 'djangojump'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

filetype plugin indent on     " required!
"
"ctrlp设置
"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']


let NERDTreeIgnore=['\.pyc']
let g:airline_powerline_fonts                   = 1 " 使用 powerline 打过补丁的字体
let g:airline#extensions#tabline#enabled        = 1 " 开启 tabline
let g:airline#extensions#tabline#buffer_nr_show = 1 " 显示 buffer 编号
let g:airline#extensions#ale#enabled            = 1 " enable ale integration
"状态栏显示图标设置
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep          = '='
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '='
let g:airline_right_alt_sep     = '⮃'
let g:airline_symbols.crypt     = '🔒'
let g:airline_symbols.linenr    = '⭡'
let g:airline_symbols.branch    = '⭠'
" 切换 buffer
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
 
" 关闭当前 buffer
noremap <C-x> :w<CR>:bd<CR>
" <leader>1~9 切到 buffer1~9
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
function! AccentDemo()
  let keys = ['a','b','c','d','e','f','g','h']
  for k in keys
    call airline#parts#define_text(k, k)
  endfor
  call airline#parts#define_accent('a', 'red')
  call airline#parts#define_accent('b', 'green')
  call airline#parts#define_accent('c', 'blue')
  call airline#parts#define_accent('d', 'yellow')
  call airline#parts#define_accent('e', 'orange')
  call airline#parts#define_accent('f', 'purple')
  call airline#parts#define_accent('g', 'bold')
  call airline#parts#define_accent('h', 'italic')
  let g:airline_section_a = airline#section#create(keys)
endfunction
autocmd VimEnter * call AccentDemo()
set laststatus=2  "永远显示状态栏
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1
"----------------------settings for airline（状态栏增强）------------------------------"
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set completeopt=menu
au BufWinLeave *.* silent mkview
au BufWinEnter *.* silent loadview
"ale
let g:ale_lint_on_text_changed       = 'normal'                     " 代码更改后启动检查 
let g:ale_lint_on_insert_leave       = 1                            " 退出插入模式即检查
let g:ale_sign_column_always         = 1                            " 总是显示动态检查结果
let g:ale_sign_error                 = '>>'                         " error 告警符号
let g:ale_sign_warning               = '--'                         " warning 告警符号
let g:ale_echo_msg_error_str         = 'E'                          " 错误显示字符
let g:ale_echo_msg_warning_str       = 'W'                          " 警告显示字符
let g:ale_echo_msg_format            = '[%linter%] %s [%severity%]' " 告警显示格式
 
" C 语言配置检查参数
let g:ale_c_gcc_options              = '-Wall -Werror -O2 -std=c11'
let g:ale_c_clang_options            = '-Wall -Werror -O2 -std=c11'
let g:ale_c_cppcheck_options         = ''
" C++ 配置检查参数
let g:ale_cpp_gcc_options            = '-Wall -Werror -O2 -std=c++14'
let g:ale_cpp_clang_options          = '-Wall -Werror -O2 -std=c++14'
let g:ale_cpp_cppcheck_options       = ''
 
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'c++': ['clang', 'gcc'],
\   'c': ['clang', 'gcc'],
\   'python': ['pylint'],
\}
" <F7> 触发/关闭代码动态检查
map <F7> :ALEToggle<CR>
"普通模式下，ak 前往上一个错误或警告，aj 前往下一个错误或警告                                                                                                                                                    
map ak <Plug>(ale_previous_wrap)
map aj <Plug>(ale_next_wrap)
" ad 查看错误或警告的详细信息
nmap ad :ALEDetail<CR>
"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
"文件内容发生变化时不进行检查
let g:ale_lint_on_text_changed = 'never'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}
"if has('gui_running')
"   set background=light
"   colorscheme solarized
"else 
"   set background=light
"   colorscheme zenburn
"endif
"call togglebg#map("<F4>")
colorscheme gruvbox
"colorscheme desert
"map <C-F6> :NextColorScheme<CR>
"imap <C-S> :NextColorScheme<CR>
"map <F11> :PreviousColorScheme<CR>
"imap <F11> <ESC> :PreviousColorScheme<CR>
""""""""""""""""""""""""""""""""""""
let g:rehash256 = 1
let g:molokai_original = 1
let g:tagbar_ctags_bin='/usr/local/bin/ctags'  " 设置ctags所在路径
"""""""""""""""""""""""""""""""""""
"NERDTreeToggle
"去除第一行的帮助提示
"let NERDTreeMinimalUI=1
"在左边占多宽
let NERDTreeWinSize=28
"不高亮显示光标所在的文件
let NERDTreeHighlightCursorline=0
"当前目录的设定
let NERDTreeChDirMode = 2
"自动退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
"打开vim时自动打开
autocmd vimenter * NERDTree
"<F2>作为toggle
nmap <F3> :NERDTreeToggle<CR>

"Tagbar######################################################
"在这儿设定二者的分布
let g:tagbar_vertical = 25
"去除第一行的帮助信息
let g:tagbar_compact = 1
"当编辑代码时，在Tagbar自动追踪变量
let g:tagbar_autoshowtag = 1
"个人爱好，展开关闭文件夹的图标
let g:tagbar_iconchars = ['▸', '▾']
"<F3>作为toggle
nmap <F9> :TagbarToggle<CR>
"打开vim时自动打开
autocmd VimEnter * nested :TagbarOpen
wincmd l
"如果不加这句，打开vim的时候当前"
autocmd VimEnter * wincmd l
"将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
let NERDTreeWinPos="right"

"ZiDongDaKai
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.py,*.erl,*.go call tagbar#autoopen()  
""""""""""""""""""""""""""""""""""""""""""
"duowenjian
let g:NERDSpaceDelims            = 1                                    " 在注释符号后加一个空格
let g:NERDCompactSexyComs        = 1                                    " 紧凑排布多行注释
let g:NERDDefaultAlign           = 'left'                               " 逐行注释左对齐
let g:NERDAltDelims_java         = 1                                    " JAVA 语言使用默认的注释符号
let g:NERDCustomDelimiters       = {'c': {'left': '/*', 'right': '*/'},'py':{'left':'"""','right':'"""'},'go':{'reft':'//'}} " C,cpp,python,go 语言注释符号
let g:NERDCommentEmptyLines      = 1                                    " 允许空行注释
let g:NERDTrimTrailingWhitespace = 1                                    " 取消注释时删除行尾空格
let g:NERDToggleCheckAllLines    = 1                                    " 检查选中的行操作是否成功
""""""""""""""""""""""""""""""""""""""
let g:EasyGrepMode = 2       " All:0, Open Buffers:1, TrackExt:2, 
let g:EasyGrepCommand = 0    " Use vimgrep:0, grepprg:1
let g:EasyGrepRecursive  = 1 " Recursive searching
let g:EasyGrepIgnoreCase = 1 " not ignorecase:0
let g:EasyGrepFilesToExclude = "*.bak, *~, cscope.*, *.a, *.o, *.pyc, *.bak"
""""""""""""""""""""""""""""""""""""""
"duiqixian"
let g:indent_guides_enable_on_vim_startup = 1 "添加行，vim启动时启用
let g:indent_guides_start_level = 1           "添加行，开始显示对齐线的缩进级别
let g:indent_guides_guide_size  = 1           "添加行，对齐线的宽度，（1字符）
let g:indent_guides_tab_guides  = 0           "添加行，对tab对齐的禁
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
""""""""""""""undotree""""""""""""""""""""""""""
nmap wm :UndotreeToggle<CR>
""""""""""""""python-syntax""""""""""""""""""""""
let python_highlight_all=1
"""""""""""""""vim-go"""""""""""""""
let g:go_version_warning          = 0
let g:go_highlight_types          = 1
let g:go_highlight_fields         = 1
let g:go_highlight_functions      = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators      = 1
let g:go_highlight_extra_types    = 1
""""""""""""""""""""""""""""""""""""""""""
"set tags+=/home/wuhuaqin11/cpp.
" OmniCppComplete"c/c++" 
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1 
"let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表 
"let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
"let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全 
"let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全 
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口 
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif 
"set completeopt=menuone,menu,longest
""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf='/home/wuhuaqin11/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
"默认配置文件路径"
"打开vim时不再询问是否加载ycm_extra_conf.py配置"
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
"python解释器路径"
let g:ycm_path_to_python_interpreter='/usr/bin/python'
"是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"开始补全的字符数"
let g:ycm_min_num_of_chars_for_completion=2
"补全后自动关机预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1
" 禁止缓存匹配项,每次都重新生成匹配项"
let g:ycm_cache_omnifunc=0
"字符串中也开启补全"
let g:ycm_complete_in_strings = 1
"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"上下左右键行为"
inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'
""""""""""""""""""""""""""""""""""""""""""""""