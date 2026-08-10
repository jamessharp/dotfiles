---
name: manage-chezmoi-dotfiles
description: Keep user dotfiles and machine configuration synchronized through chezmoi, including validation and automatic Git commit and push. Use whenever an agent edits, creates, removes, or reorganizes durable user configuration on this machine—even when chezmoi is not mentioned—including ~/.config/**, shell startup files, terminal or prompt configuration, desktop settings, SSH or Git configuration, and other application settings under the home directory. Do not use for ordinary project source code, generated state, histories, caches, or temporary files.
---

# Manage Chezmoi Dotfiles

Treat `/home/james/.local/share/chezmoi` as the source repository for durable user configuration. Keep the live configuration and source state synchronized, validate the result, then commit and push the exact source changes made by the task.

## Inspect Before Editing

1. Check whether each target is managed with `chezmoi managed --path-style absolute <target>`.
2. Resolve its source with `chezmoi source-path <target>` and inspect both target and source before editing.
3. Inspect `git -C /home/james/.local/share/chezmoi status -sb` and the relevant diffs. Preserve unrelated worktree changes.
4. Use any other applicable configuration skill as well; this skill governs synchronization and publication, not application-specific semantics.

Do not add credentials, private keys, tokens, histories, caches, generated state, or files likely to contain secrets unless the user explicitly requests secure chezmoi management for them.

## Make and Synchronize Changes

- For an ordinary managed file, edit the live target, validate it, then run `chezmoi add <target>`.
- For a templated source such as `*.tmpl`, edit the source file directly. Render or syntax-check the template, then run `chezmoi apply <target>` so the live file matches.
- For a new durable dotfile or configuration file, make the requested change and add it with `chezmoi add <target>` when it is safe and contains no secrets.
- For removals, use the appropriate chezmoi removal workflow so both source and target reflect the request. Resolve the exact paths before deleting anything.
- After synchronization, run `chezmoi diff <target>`. Investigate unexpected output rather than overwriting it.

Validate in proportion to the change. Examples include parsing configuration, running application-specific checks, or rendering a template and passing it to `zsh -n`.

## Commit and Push

Completion includes committing and pushing the relevant chezmoi source changes. The user has granted standing authorization for these publication steps when this skill applies; do not ask for separate confirmation.

1. Inspect the repository status and diff again.
2. Stage only source paths belonging to the current task. Never use `git add -A` in a mixed worktree.
3. If intended and unrelated edits overlap in the same file and cannot be separated safely, stop and ask the user instead of publishing unrelated work.
4. Run `git diff --cached --check` and any relevant validation.
5. Create a concise commit describing the configuration change.
6. Push the current branch to its configured upstream. Do not create a branch or pull request for routine dotfile updates unless requested.
7. Confirm that the pushed commit is at the upstream tip and report the commit identifier.

If validation, commit, or push fails, preserve the work and report the exact blocker. Do not rewrite history, force-push, discard unrelated changes, or silently broaden the commit.
