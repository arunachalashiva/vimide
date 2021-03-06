# vim IDE in a docker
vim configuration that I use, packaged in a docker and has the below programming languages installed. Docker image
also include other system tools used by these plugins (like clang, autopep8).
## Languages
* java - version 1.11
	* 'YouCompleteMe' for completion (jdt.ls also include support for lombok)
	* 'ALE' for linting (javac) and fixing (using google-java-format)
* python 3.8
	* 'YouCompleteMe' for completion (jedi)
	* 'ALE' for linting (autopep8) and fixing (using yapf)
* c++
	* 'YouCompleteMe' for completion
	* 'ALE' for linting (clangtidy) and fixing (using clangtidy, clang-format)
* go 1.16
	* 'YouCompleteMe' for completion (gopls)
	* 'ALE' for linting (gofmt) and fixing (using gopls)

## Tools
* fzf - To search for files, git commits, tags, Rg grep
* fugitive - Git wrapper
* Nerdtree - File explorer
* gitgutter - Display git diff in sign column
* Nerdcommenter - For comments
* vim-dispatch - Shell command execution. Also Used by other plugins
* mvndisp - Maven compile/test (used vim-dispatch)

## Look and feel
* onedark - Default theme
* Goyo - Distraction free
* airline - Status/Tabline

## Help for Shortcuts and Commands
`:HelpVimide` outputs the custom defined shortcuts and commands.
Below is the output of `:HelpVimide`
```
vimide shortcuts
'\h'  - Display this help
'<ctrl-Left>'  - Switch to previous buffer
'<ctrl-Right>' - Switch to next buffer
'\bd' - buffer delete - Deletes current buffer
'\nt' - nerdtree toggle - Open/Close NERDTree
'\ff' - find files - Open fzf Files
'\ft' - find tags - Open fzf Tags
'\fg' - find grep pattern - Open fzf Rg (grep)
'\fw' - find grep pattern for current word under cursor using Rg
'\af' - Run ALEFix (fixer for lint errors)
'\yf' - Run YouCompleteMe FixIt
'\yr' - List References - YouCompleteMe GoToReferences
'\yd' - GotTo Documentation - YouCompleteMe GetDoc
'\yt' - GetType - YouCompleteMe GetType
'\yg' - Go to definition - YouCompleteMe GoTo - <ctrl-o> to go back
'\op' - Open Project - Calls OpenProject <dir> directory and refresh NERDTree
'\om' - Open Markdown Viewer - Opens Markdown viewer in chrome (port 6419) using grip 
'\mas' - Run :MvnCompile all (entire project)
'\mat' - Run :MvnTest all (entire project)
'\mms' - Run :MvnCompile submodule
'\mmt' - Run :MvnTest module (current submodule)
'\mtt' - Run :MvnTest this (current test file)
'\mca' - Run :MvnClean all (entire project)
'\mcm' - Run :MvnClean module (current submodule)
vimide commands
':OpenProject <dir>' - Switch to <dir> directory and refresh NERDTree
```
