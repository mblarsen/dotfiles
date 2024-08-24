# local bin
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.config/zsh/bin:$PATH

# snap
export PATH=$PATH:/snap/bin

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# ???
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"

# composer
if [ -f "$HOME/.phpenv/version" ]; then
  PHP_VERSION=$(cat $HOME/.phpenv/version)
  export PATH=$HOME/.phpenv/versions/$PHP_VERSION/composer/bin:$PATH
fi

# rust/cargo
export PATH=$HOME/.cargo/bin:$PATH

# Android NDK
export ANDROID_NDK_HOME="/opt/homebrew/share/android-ndk"

# Java
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# lua-language-server
export PATH="$HOME/src/lua-language-server/bin/macOS:$PATH"

# vector
export PATH="$HOME/.vector/bin:$PATH"

# bob nvim
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# ruby
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
