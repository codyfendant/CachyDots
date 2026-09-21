# New Computer Setup — Dotfiles (CachyDots)

Repo: `git@github.com:codyblisss/CachyDots.git`
Method: bare git repo, work-tree = `$HOME`, alias = `dotfiles`

---

## 1. Install git

```bash
sudo pacman -S git      # Arch/CachyOS
brew install git        # macOS
```

## 2. Generate an SSH key (new key per machine)

```bash
ssh-keygen -t ed25519 -C "codyblisss@gmail.com"
```
Press Enter to accept the default path (`~/.ssh/id_ed25519`).

**Start the agent and load the key:**

Linux (bash/fish):
```bash
eval (ssh-agent -c)        # fish
eval "$(ssh-agent -s)"     # bash
ssh-add ~/.ssh/id_ed25519
```

macOS (zsh):
```zsh
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```
Optional — auto-load the key on every login by adding to `~/.ssh/config`:
```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

## 3. Add the key to GitHub

```bash
cat ~/.ssh/id_ed25519.pub     # Linux — copy manually
pbcopy < ~/.ssh/id_ed25519.pub # macOS — copies to clipboard
```
Go to **https://github.com/settings/keys** → **New SSH key** → paste → name it (e.g. "MacBook", "CachyOS-laptop") → Save.

**Test it:**
```bash
ssh -T git@github.com
```
Should say: `Hi codyblisss! You've successfully authenticated...`

## 4. Clone the bare repo

```bash
git clone --bare git@github.com:codyfendant/CachyDots.git $HOME/.cachydots
```

## 5. Set up the `dotfiles` alias

fish (`~/.config/fish/config.fish`):
```fish
echo "alias dotfiles='/usr/bin/git --git-dir=\$HOME/.cachydots/ --work-tree=\$HOME'" >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

bash/zsh (`~/.bashrc` or `~/.zshrc`):
```bash
echo "alias dotfiles='/usr/bin/git --git-dir=\$HOME/.cachydots/ --work-tree=\$HOME'" >> ~/.zshrc
source ~/.zshrc
```

Then hide untracked files from `status` (do this on every machine):
```bash
dotfiles config --local status.showUntrackedFiles no
```

## 6. Checkout the files

```bash
mkdir -p ~/.config-backup
dotfiles checkout
```

If it errors with "would be overwritten by checkout," back up the conflicting files first, then retry:

```fish
for file in (dotfiles checkout 2>&1 | grep -E "^\s" | awk '{print $1}')
    mkdir -p (dirname ~/.config-backup/$file)
    mv ~/$file ~/.config-backup/$file
end
dotfiles checkout
```

## 7. Sanity check

```bash
dotfiles status
```
Should be clean. Then confirm key configs actually landed:
```bash
ls -la ~/.config/nvim ~/.config/kitty ~/.config/fish
```

---

## Adding / restoring specific folders or files later

You don't have to restore everything at once — you can pull in individual configs as needed.

**Restore one file or folder from the repo to its config location:**
```bash
dotfiles checkout -- .config/nvim
dotfiles checkout -- .config/kitty/kitty.conf
dotfiles checkout -- .config/fish/config.fish
```
This pulls the repo's version straight into place — no need to clone separately or copy manually, since `dotfiles` already points at `$HOME` as the work-tree.

**Add a new file/folder to the repo for the first time:**
```bash
dotfiles add ~/.config/newapp
dotfiles commit -m "Add newapp config"
dotfiles push
```

**Pull the latest changes from GitHub into an already-set-up machine:**
```bash
dotfiles pull
```

---

## Regular update workflow (after this machine is set up)

```bash
dotfiles status                    # see what changed
dotfiles add -u                    # stage changes to already-tracked files only
dotfiles commit -m "Update configs"
dotfiles push
```

Optional fish shortcut — save as `~/.config/fish/functions/dotsave.fish`:
```fish
function dotsave
    dotfiles add -u
    dotfiles commit -m "$argv"
    dotfiles push
end
```
Then just run: `dotsave "Update nvim config"`

---

## Common gotchas

**"You've added another git repository inside your current repository"**
A folder (theme, plugin, starter config) has its own `.git` inside it. Strip it before adding:
```bash
rm -rf ~/.config/<folder>/.git
dotfiles add ~/.config/<folder>
```

**"fatal: in unpopulated submodule"**
Git still has a stale submodule reference in its index. Clear it, then re-add:
```bash
dotfiles rm -r --cached --ignore-unmatch .config/<folder>
dotfiles add ~/.config/<folder>
```

**Removing a folder from tracking (keep the files on disk):**
```bash
dotfiles rm -r --cached .config/<folder>
echo ".config/<folder>" >> ~/.gitignore
dotfiles add ~/.gitignore
dotfiles commit -m "Stop tracking <folder>"
dotfiles push
```

**First push conflicts (repo already has a README/LICENSE):**
```bash
dotfiles pull origin main --allow-unrelated-histories
# resolve conflicts if any, then:
dotfiles push -u origin main
```

---

## Platform notes

- **niri** configs are Linux/Wayland-only — harmless but non-functional on macOS.
- **kitty** and **fish** work cross-platform without changes.
- Watch for hardcoded Linux paths (`/usr/bin/...`, systemd units) in configs when restoring on macOS.
