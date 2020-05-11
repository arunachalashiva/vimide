# vim IDE in a docker
vim configuration that I use, packaged in a docker and has the below programming languages installed. Docker image
also include other system tools used by these plugins (like clang, autopep8).
## Languages
* java - version 1.8
	* 'YouCompleteMe' for completion (jdt.ls also include support for lombok)
	* 'ALE' for linting (javac) and fixing (using google-java-format)
* python 3.6
	* 'YouCompleteMe' for completion (jedi)
	* 'ALE' for linting (autopep8) and fixing (using yapf)
* c++
	* 'YouCompleteMe' for completion
	* 'ALE' for linting (clangtidy) and fixing (using clangtidy, clang-format)
* go 1.14
	* 'YouCompleteMe' for completion (gopls)
	* 'ALE' for linting (autopep8) and fixing (using yapf)

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
'\t'  - Open Close NERDTree
'\ff' - Open fzf Files
'\ft' - Open fzf Tags
'\fg' - Open fzf Rg (grep)
'\af' - Run ALEFix (fixer for lint errors)
'\yf' - Run YouCompleteMe FixIt
'<Ctrl><Left>' - Switch to previous buffer
'<Ctrl><Right>' - Switch to next buffer
'\cd' - Calls CDir <dir> directory and refresh NERDTree
'\mas' - Run :MvnCompile all
'\mat' - Run :MvnTest all
'\mms' - Run :MvnCompile submodule
'\mmt' - Run :MvnTest submodule
'\mtt' - Run :MvnTest current-test
vimide commands
':CDir <dir>' - Switch to <dir> directory and refresh NERDTree
```
