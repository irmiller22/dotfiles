export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Environment Variables
# =====================
  # Library Paths
  # These variables tell your shell where they can find certain
  # required libraries so other programs can reliably call the variable name
  # instead of a hardcoded path.

    # NODE_PATH
    # Node Path from Homebrew I believe
    export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

    # PYTHON_SHARE
    # Python Shared Path from Homebrew I believe
    export PYTHON_SHARE='/usr/local/bin/python'

    # Those NODE & Python Paths won't break anything even if you
    # don't have NODE or Python installed. Eventually you will and
    # then you don't have to update your bash_profile

    # ELIXIR_PATH
    export ELIXIR_PATH="/usr/local/bin/elixir"

    # GO_PATH
    export GO_PATH="/usr/local/go/bin/go"

  # Paths

    # The USR_PATHS variable will just store all relevant /usr paths for easier usage
    # Each path is seperate via a : and we always use absolute paths.

    # A bit about the /usr directory
    # The /usr directory is a convention from linux that creates a common place to put
    # files and executables that the entire system needs access too. It tries to be user
    # independent, so whichever user is logged in should have permissions to the /usr directory.
    # We call that /usr/local. Within /usr/local, there is a bin directory for actually
    # storing the binaries (programs) that our system would want.
    # Also, Homebrew adopts this convetion so things installed via Homebrew
    # get symlinked into /usr/local
    export USR_PATHS="/usr/local:/usr/local/sbin:/usr/bin"

    export POSTGRES_PATH="/Applications/Postgres.app/Contents/Versions/latest/bin"
    export MYSQL_PATH="/usr/local/bin/mysql"
    # Our PATH variable is special and very important. Whenever we type a command into our shell,
    # it will try to find that command within a directory that is defined in our PATH.
    # Read http://blog.seldomatt.com/blog/2012/10/08/bash-and-the-one-true-path/ for more on that.

    export PATH="/usr/local/bin:$USR_PATHS:$PATH:$GO_PATH:$PYTHON_SHARE:$ELIXIR_PATH:$POSTGRES_PATH:$MYSQL_PATH"

# Final Configurations and Plugins
# =====================
  # Git Bash Completion
  # Will activate bash git completion if installed
  # via homebrew
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion

    # Git completion aliases
    __git_complete g __git_main
    __git_complete gco _git_checkout
    __git_complete gm __git_merge
    __git_complete gp _git_pull
    __git_complete gb _git_branch
    __git_complete gbd _git_branch -D
  fi

source ~/.profile
source ~/.venv_config
