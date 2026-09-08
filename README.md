# dotfiles

Reusable personal dotfiles, managed with [chezmoi](https://chezmoi.io/).
Shell, Git and application preferences are shared; platform-specific files are
selected by the macOS or Omarchy profile.

Machine services, display hardware, networking, backup policy, credentials and
agent runtime/workspace state stay local. Optional `~/.gitconfig.local` and
`~/.zshrc.local` files provide per-machine overrides and are not managed here.
Set the machine's Git signing key in `~/.gitconfig.local` before committing;
commit signing is enabled by the shared Git preferences.

Before adding content, check that it is reusable and suitable for public sharing.
The `private_` chezmoi prefix sets target permissions; it does not encrypt files
or hide them from Git. Removing a file does not remove its Git history.

## License

MIT
