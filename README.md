# dotfiles

### To Interested Parties

I don't take my bash very seriously. Based on my experience, it's an irregular language, so at least for now, I've consciously decided not to invest the effort in learning how to write it well-- except as a means to accomplishing tasks. Life is short, and there are other, more interesting, higher-leverage things to learn. In addition, I'm the only one working with this code. So, it's not representative of my typical writing style.

### Notes

I recommend creating a symlink for your `.bashrc` so you don't have to deal with a git repo in your home directory:

```
cd ~
ln -s Documents/my-repos/dotfiles/.bashrc .bashrc
ln -s Documents/my-repos/dotfiles/.bash_profile .bash_profile
```

```
you@somewhere:~$ ls -la
total ...
...
lrwxrwxrwx  1 mkw  mkw    38 Nov 27 08:30 .bash_profile -> Documents/my-repos/dotfiles/.bash_profile
lrwxrwxrwx  1 mkw  mkw    32 Nov 27 08:28 .bashrc -> Documents/my-repos/dotfiles/.bashrc
...
```
