---
name: manage-chezmoi-dotfiles
description: Maintain reusable personal dotfiles in chezmoi. Use when editing existing managed dotfiles or adding cross-machine shell, editor, Git, terminal, or desktop preferences. Keep machine-specific configuration and agent runtime state local.
---

# Manage Chezmoi Dotfiles

This is a public repository of reusable personal dotfiles, not a machine backup.
Discover its location with `chezmoi source-path`; never hardcode a username or
source directory.

## Decide what belongs

- Keep preferences and helpers intended for reuse across the user's machines.
  Gate platform-specific content by OS or desktop environment. Use chezmoi's
  home-directory data instead of absolute user paths.
- Keep host services/autostart, hardware/display profiles, network topology,
  backup policy, machine-specific key selection, local project paths, and agent
  identities/workspaces/runtime state outside the repository. A hostname gate
  does not make host-only content generic. A local-only edit does not need a
  chezmoi change or publication.
- Keep credentials, private keys, tokens, histories, caches and generated state
  out of source control. `private_` changes file permissions, not Git visibility;
  `.chezmoiignore` controls deployment, not publication.
- For mixed configuration, separate reusable defaults from an optional untracked
  local include or local chezmoi data. Preserve the existing machine's behavior.
  User instructions to keep a file local take precedence over synchronization.

## Edit and validate

1. Inspect repository status and relevant diffs. Check management with
   `chezmoi managed --path-style absolute <target>` and resolve existing sources
   with `chezmoi source-path <target>`. Preserve unrelated edits.
2. For ordinary managed files, edit the live target and use `chezmoi add <target>`
   to synchronize only the intended file. For templates, edit the source and
   inspect the rendered diff before applying only the affected target.
3. Before adding a new file, establish that it contains reusable preferences
   suitable for public sharing. Do not recursively add a home/config directory.
4. To stop managing host-only content, use `chezmoi forget --force <target>` and
   verify that live files/symlinks are preserved. Do not use a removal operation
   that deletes the live target. Add appropriate ignore rules against recurrence.
5. Check `chezmoi diff <target>` and validate affected syntax/platform gates.
   Never use a whole-home apply merely to verify a narrow change.

## Commit and publication

Review the exact source diff for public suitability and generic scope. When
committing, stage only task-owned paths and run `git diff --cached --check`.
Follow the user's existing Git workflow and authorization. This skill grants
no standing permission to push: publish only when the conversation authorizes
it. Do not rewrite published history or force-push as routine cleanup; deleting
current files does not remove historical copies.
