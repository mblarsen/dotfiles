# dotfiles

dotfiles managed by [yadm].

* vim
* wezterm
* etc

[yadm]: https://github.com/TheLocehiliosan/yadm

# linux box

Based on Ubuntu 24

```
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

# follow link and approve
# disable expiry to avoid being locked out

tailscale ip -4

# write down the ip

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow in on tailscale0
sudo ufw status verbose

# remove any non-tailscale or leave 80/443 if needed
# you can also remove 22

sudo ufw reload
sudo service ssh restart

# test connection works
ssh <username>@<server host ip>

# change hostname
hostnamectl set-hostname plumb

sudo adduser mbl
sudo usermod  -aG sudo mbl

sudo apt install zsh -y
sudo chsh -s /usr/bin/zsh mbl
sudo su - mbl
cd
mkdir .ssh
chmod 2700 .ssh
vim .ssh/authorized_keys # insert public key
```

```
Host plumb
  HostName <ip-from-before>
  IdentityFile "~/.ssh/<private-key>"
  IdentitiesOnly yes
  SetEnv TERM=xterm-256color
  LocalForward 8788 127.0.0.1:8384
  LocalForward 4200 127.0.0.1:4200
```

```
curl -s "https://raw.githubusercontent.com/mblarsen/dotfiles/refs/heads/main/setup.sh%23%23os.Linux" > setup.sh
chmod +x ./setup.sh

./setup.sh # say yes some times

# copy ~/.ssh/github_ed25519.pub to GitHub SSH auth keys
```

```
Host github.com
  IdentityFile "~/.ssh/github_ed25519
  IdentitiesOnly yes
```

```
yadm clone git@github.com:mblarsen/dotfiles.git

# log in and out a bit for zplug to work

pyenv install 3.11.11
pyenv global 3.11.11

Run ./setup again for the remaining
```

## Resources

[Guide](https://tailscale.com/kb/1077/secure-server-ubuntu)
