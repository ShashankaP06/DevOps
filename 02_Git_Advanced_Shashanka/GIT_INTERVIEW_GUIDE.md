# Git Interview Guide for DevOps Engineers

This guide covers the Git concepts commonly asked in DevOps, release
engineering, CI/CD, and platform-engineering interviews.

## 1. Git Fundamentals

### What is Git?

Git is a distributed version-control system. It records snapshots of files,
supports parallel development through branches, and allows every clone to hold
the complete repository history.

### Git vs GitHub

- Git is the version-control software.
- GitHub is a hosted collaboration platform built around Git.
- Git works locally without GitHub or internet access.
- Alternatives to GitHub include GitLab, Bitbucket, and Azure Repos.

### What does distributed version control mean?

Each developer normally has:

- A working copy of the files.
- A staging area.
- A complete local repository with commit history.

Developers can commit, branch, inspect history, and restore files offline.

### What are Git's main areas?

1. **Working tree**: files currently being edited.
2. **Staging area/index**: selected changes for the next commit.
3. **Local repository**: committed history in `.git`.
4. **Remote repository**: shared copy hosted elsewhere.

### What is the `.git` directory?

It stores repository metadata, including commits, branches, tags, configuration,
the staging index, and references. Removing `.git` removes the repository
history while leaving the working files.

### What is a commit?

A commit is an immutable snapshot containing:

- A tree representing the project files.
- One or more parent commits.
- Author and committer information.
- Timestamp and commit message.
- A unique hash.

### What is a commit hash?

It is the identifier calculated from the commit's contents and metadata. Git
often displays a short form such as `48afe80`, while internally using the full
hash.

### What is `HEAD`?

`HEAD` identifies the currently checked-out commit. Normally it points
indirectly through the current branch:

```text
HEAD -> main -> latest commit
```

### What is a detached HEAD?

It occurs when `HEAD` points directly to a commit rather than a branch. Commits
can still be created, but they may become difficult to find unless a branch or
tag is created for them.

```bash
git switch -c recovery-branch
```

### Basic daily commands

```bash
git status
git add <file>
git commit -m "Clear message"
git log --oneline
git diff
git pull
git push
```

## 2. Tracking and Staging

### What are untracked, modified, staged, and committed files?

- **Untracked**: Git does not yet include the file in history.
- **Modified**: a tracked file differs from the latest commit.
- **Staged**: the change is selected for the next commit.
- **Committed**: the snapshot is stored in repository history.

### `git add file` vs `git add .`

- `git add file` stages one specific path.
- `git add .` stages changes under the current directory.
- `git add -A` stages additions, modifications, and deletions across the repo.
- Specific paths are safer when unrelated changes exist.

### `git commit -a` limitation

`git commit -a` stages modified and deleted **tracked** files. It does not stage
new untracked files.

### `git diff` variants

```bash
git diff             # working tree vs staging area
git diff --staged    # staging area vs latest commit
git diff HEAD        # all uncommitted changes vs latest commit
git diff A..B        # differences between two commits/branches
```

### What is `.gitignore`?

It defines intentionally untracked paths, such as build output, logs, local
configuration, and dependencies.

It does not stop tracking a file already committed. To untrack one:

```bash
git rm --cached <file>
```

Never rely on `.gitignore` to protect secrets already committed.

### What is `.gitattributes`?

It controls path-specific Git behavior such as line endings, diff drivers, and
merge handling.

```gitattributes
*.sh text eol=lf
```

This prevents Windows CRLF line endings from breaking shell scripts on Linux.

## 3. Branches

### What is a branch?

A branch is a movable pointer to a commit. It does not duplicate the entire
project.

### Create and switch branches

```bash
git switch -c feature/login
git switch main
```

Older equivalent:

```bash
git checkout -b feature/login
git checkout main
```

### List and delete branches

```bash
git branch
git branch -a
git branch -d feature/login
git branch -D feature/login
git push origin --delete feature/login
```

`-d` refuses to delete an unmerged branch. `-D` forces deletion.

### Common branching strategies

#### Feature branching

Each change gets a short-lived branch and is merged through a pull request.
Suitable for many teams.

#### Trunk-based development

Developers integrate small changes into `main` frequently. Long-lived branches
are avoided, often using feature flags. This supports rapid CI/CD.

#### Git Flow

Uses long-lived `main` and `develop` branches with feature, release, and hotfix
branches. It offers structure but can add overhead and delay integration.

#### Release branches

A release branch stabilizes a specific version while new development continues
elsewhere. Bug fixes may need to be applied to both release and main branches.

### What is an upstream branch?

It is the remote branch tracked by a local branch.

```bash
git push -u origin feature/login
git branch -vv
```

After setting upstream, plain `git pull` and `git push` know the default target.

## 4. Merge and Conflicts

### What does merge do?

It combines histories. Git finds a common ancestor and integrates changes from
the source branch into the current branch.

```bash
git switch main
git merge feature/login
```

### What is a fast-forward merge?

If `main` has not changed since the feature branch was created, Git can move
the `main` pointer forward without creating a merge commit.

### What is a three-way merge?

Git compares:

1. The common ancestor.
2. The current branch.
3. The incoming branch.

It creates a merge commit with two parents when histories have diverged.

### What causes a merge conflict?

A conflict occurs when Git cannot safely decide the final content, commonly
because both branches changed the same lines differently, or one deleted a file
that the other modified.

### Conflict markers

```text
<<<<<<< HEAD
current branch content
=======
incoming branch content
>>>>>>> feature-branch
```

Resolve by editing the file to the intended final state, removing all markers,
testing the result, and then:

```bash
git add <resolved-file>
git commit
```

### Abort a merge

```bash
git merge --abort
```

This returns to the state before the merge attempt when possible.

### Merge vs rebase

- **Merge** preserves the original branch topology and may create a merge
  commit.
- **Rebase** rewrites commits onto a new base, producing linear history.
- Use merge for shared history when preserving context matters.
- Use rebase to clean private/local branch history before sharing.
- Avoid rebasing commits other people are already using unless coordinated.

## 5. Rebase

### What does rebase do?

Rebase replays commits on top of another base:

```bash
git switch feature/login
git rebase main
```

The replayed commits receive new hashes because their parent history changes.

### Interactive rebase

```bash
git rebase -i HEAD~4
```

Common actions:

- `pick`: keep the commit.
- `reword`: change its message.
- `edit`: pause to modify it.
- `squash`: combine it with the previous commit and edit messages.
- `fixup`: combine it and discard its message.
- `drop`: remove it.

### Continue or abort a rebase

```bash
git add <resolved-files>
git rebase --continue
git rebase --abort
```

### Why can rebase be dangerous?

It rewrites commit hashes. Rebasing shared commits can make collaborators'
history diverge and may require a force push.

### Safe force pushing

```bash
git push --force-with-lease
```

Prefer this over `--force`. It refuses to overwrite unexpected remote work.

## 6. Remote Repositories

### What is `origin`?

`origin` is the conventional default name for the remote from which a
repository was cloned. It is only a label.

```bash
git remote -v
git remote add origin <url>
git remote set-url origin <url>
```

### Fetch vs pull

- `git fetch` downloads remote objects and updates remote-tracking references
  without changing your working branch.
- `git pull` performs a fetch followed by merge or rebase.

Safer inspection workflow:

```bash
git fetch origin
git log HEAD..origin/main --oneline
git merge origin/main
```

### Push

```bash
git push origin main
git push -u origin feature/login
```

Push uploads local commits and updates a remote branch.

### Remote-tracking branches

`origin/main` is a local reference representing the last fetched state of the
remote `main`. It is not the same as your local `main`.

### What is a pull request?

A pull request is a hosting-platform review process proposing that one branch
be merged into another. It can include:

- Code review.
- Automated CI checks.
- Required approvals.
- Security scans.
- Discussion and change requests.

It is not a core Git object; it is a GitHub/GitLab/Bitbucket feature.

## 7. Undoing and Recovery

### Restore an unstaged file

```bash
git restore <file>
```

This discards working-tree changes. Use carefully.

### Unstage without discarding changes

```bash
git restore --staged <file>
```

### Amend the latest commit

```bash
git commit --amend
```

This replaces the latest commit and creates a new hash. Avoid amending already
shared commits unless coordinated.

### Revert vs reset

#### Revert

```bash
git revert <commit>
```

Creates a new commit that reverses an earlier commit. It preserves history and
is safest for shared branches.

#### Reset

```bash
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1
```

- `--soft`: moves the branch; changes remain staged.
- `--mixed`: moves the branch; changes remain unstaged.
- `--hard`: moves the branch and discards working/staged changes.

Use hard reset carefully, especially on shared branches.

### What is reflog?

Reflog records local movements of references such as `HEAD`. It can recover
commits after resets or rebases:

```bash
git reflog
git switch -c recovered-work <hash>
```

Reflog is local and temporary; it is not pushed to GitHub.

### Recover a deleted branch

```bash
git reflog
git branch recovered-branch <commit-hash>
```

## 8. Stash and Cherry-Pick

### What is stash?

Stash temporarily stores uncommitted changes so the working tree can become
clean.

```bash
git stash push -m "partial work"
git stash list
git stash show -p stash@{0}
git stash pop
```

- `pop` applies and removes the stash if successful.
- `apply` applies it while keeping the stash.
- Include untracked files with `git stash -u`.

### What is cherry-pick?

Cherry-pick applies the change introduced by a specific commit onto the current
branch:

```bash
git cherry-pick <commit-hash>
```

Common use: applying an urgent production fix to both a release branch and
`main`.

Avoid routinely cherry-picking the same commits across many branches because
duplicate histories become harder to manage.

## 9. Tags and Releases

### What is a Git tag?

A tag gives a stable name to a commit, commonly for releases.

```bash
git tag v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
git push origin --tags
```

- Lightweight tags are simple references.
- Annotated tags include metadata and a message and can be signed.

### What is semantic versioning?

`MAJOR.MINOR.PATCH`, for example `2.4.1`:

- MAJOR: incompatible change.
- MINOR: backward-compatible feature.
- PATCH: backward-compatible bug fix.

Pre-release example: `2.0.0-rc.1`.

### Branch vs tag

- A branch moves as commits are added.
- A tag normally remains fixed at one commit.

## 10. Git Bisect

### What does `git bisect` do?

It uses binary search to find the first commit that introduced a problem:

```bash
git bisect start
git bisect bad
git bisect good <known-good-commit>
```

Test each selected revision and mark it:

```bash
git bisect good
git bisect bad
git bisect reset
```

Automate it with:

```bash
git bisect run ./test-script.sh
```

A test exit code of `0` means good, `1-127` generally means bad, and `125`
means the commit cannot be tested.

### Why is bisect efficient?

It searches logarithmically. Roughly 10 tests can search about 1,000 commits.

## 11. Repository Internals

### Main Git object types

- **Blob**: file contents.
- **Tree**: directory structure mapping names to blobs and trees.
- **Commit**: points to a tree and parent commit(s), with metadata.
- **Tag object**: annotated metadata pointing to another object.

### Does Git store diffs?

Conceptually, Git stores snapshots. Unchanged content is reused through object
references. Packfiles may use delta compression for efficient storage.

### Why does changing history change hashes?

A commit hash includes its tree, parent, author/committer data, and message.
Changing any of these produces a different hash, which also changes descendant
commits.

### Garbage collection

```bash
git gc
```

Git packs objects and removes eligible unreachable data after retention
periods. Usually Git runs maintenance automatically.

## 12. Collaboration and Governance

### What is `CODEOWNERS`?

A GitHub/GitLab-supported file mapping paths to responsible reviewers:

```text
* @platform-team
/terraform/ @cloud-team
/.github/workflows/ @devops-team
```

Combined with branch protection, it can require approval from responsible
owners.

### Typical protected-branch controls

- Require pull requests.
- Require approvals.
- Require status checks.
- Require resolved conversations.
- Block force pushes and deletion.
- Require signed commits when appropriate.
- Restrict direct pushes.

### Good commit-message characteristics

- Imperative subject: `Add health-check endpoint`.
- Explain why when the reason is not obvious.
- Keep each commit focused.
- Reference work items when appropriate.
- Avoid messages such as `fix`, `changes`, or `wip` in final shared history.

### How should secrets be handled?

- Never commit credentials, tokens, private keys, or `.env` secrets.
- Use CI/CD secret stores or cloud secret managers.
- Enable secret scanning and pre-commit checks.
- Rotate a secret immediately if committed.
- Removing it in a later commit does not remove it from history.

History cleanup tools include `git filter-repo`, but rotation remains mandatory.

### Signed commits and tags

Cryptographic signatures can prove that a commit or tag was created by the
holder of a trusted key. Git supports GPG and SSH signing.

## 13. DevOps and CI/CD Scenarios

### A pipeline fails after a recent merge. What do you do?

1. Inspect the failed job and logs.
2. Reproduce the failure when possible.
3. Compare recent commits.
4. Use `git bisect` if the regression point is unclear.
5. Revert the bad commit on shared branches if rapid restoration is required.
6. Fix forward through a reviewed branch.

### How do you promote the same artifact across environments?

Build once from a specific immutable commit, assign an artifact version or
image digest, and promote that exact artifact through test, staging, and
production. Do not rebuild independently per environment.

### How should CI identify a build?

Common identifiers:

- Full commit SHA.
- Short SHA for display.
- Semantic release tag.
- Pipeline/build number.
- Container image digest.

The commit SHA provides traceability from artifact to source.

### How do you handle a production hotfix?

1. Branch from the production tag or release branch.
2. Implement and test the smallest safe fix.
3. Review and deploy it.
4. Tag the release.
5. Merge or cherry-pick the fix back into `main` and other maintained branches.

### A developer force-pushed and removed commits. Can they be recovered?

Check:

- Local reflogs of developers who fetched the commits.
- CI workspaces or deployment metadata.
- Existing pull-request references.
- Other local or remote branches/tags.

Create a branch from the recovered hash and push it safely.

### How do you resolve conflicts in a pull request?

1. Update the feature branch from the target branch using merge or rebase.
2. Resolve each conflict intentionally.
3. Run tests.
4. Inspect the final diff.
5. Push the resolution.
6. Obtain renewed review if the change is significant.

### Why avoid direct commits to `main`?

Pull requests provide review, CI checks, traceability, security enforcement,
and controlled integration. Protected branches reduce accidental production
changes.

### Why should CI checkout full history sometimes?

Shallow clones are faster, but full history may be required for:

- `git bisect`.
- Version calculation from tags.
- changelog generation.
- merge-base analysis.
- history-based security or compliance checks.

## 14. Common Interview Scenarios

### You committed to the wrong local branch but have not pushed.

```bash
git branch correct-branch
git reset --hard HEAD~1
git switch correct-branch
```

Another option is to switch to the correct branch and cherry-pick the commit,
then remove it from the wrong branch.

### You staged the wrong file.

```bash
git restore --staged <file>
```

The working-file changes remain.

### You committed a wrong file locally.

```bash
git rm --cached <file>
git commit --amend
```

If it contained a secret, rotate the secret even if it was never intentionally
shared.

### You pushed a bad commit to `main`.

Prefer:

```bash
git revert <bad-commit>
git push
```

This preserves shared history. Avoid rewriting `main` unless there is a
carefully coordinated emergency.

### Your local branch is behind remote.

```bash
git fetch origin
git rebase origin/main
```

or:

```bash
git pull --rebase
```

Use the workflow agreed by the team.

### A merge or rebase becomes confusing.

```bash
git status
git merge --abort
git rebase --abort
```

Read `git status` before taking destructive action.

### A file should differ per environment.

Do not maintain secret or environment-specific values through repeated Git
edits. Use templates plus environment variables, configuration services, or
secret managers.

### Large binary files are making the repository huge.

Use Git LFS for appropriate large assets and avoid committing generated
artifacts. Removing old large blobs may require history rewriting with
`git filter-repo`.

## 15. Hooks, Submodules, and Worktrees

### Git hooks

Hooks are scripts triggered by Git events:

- `pre-commit`: local checks before commit creation.
- `commit-msg`: validate commit-message format.
- `pre-push`: checks before pushing.
- Server-side hooks can enforce central policy.

Local hooks are not automatically cloned. Tools such as pre-commit frameworks
help teams version and install hook configuration.

### Submodules

A submodule records a specific commit of another repository inside a parent
repository.

```bash
git submodule add <url> path
git submodule update --init --recursive
```

They provide explicit version pinning but require careful cloning, updating,
and CI handling.

### Why was our nested practice repository problematic?

A normal repository placed inside another repository is treated as an embedded
repository and its internal history is not stored as ordinary parent-repo
files. Our exercises therefore run in `~/git-advanced-practice`, while evidence
is exported into this portfolio repository.

### Worktrees

Worktrees allow multiple branches from one repository to be checked out in
separate directories:

```bash
git worktree add ../hotfix hotfix-branch
git worktree list
git worktree remove ../hotfix
```

They are useful for simultaneous release and feature work without repeated
stashing or cloning.

## 16. Useful Diagnostic Commands

```bash
git status
git log --oneline --graph --decorate --all
git show <commit>
git diff
git diff --staged
git branch -vv
git remote -v
git reflog
git blame <file>
git log -- <file>
git rev-parse --show-toplevel
git merge-base branch-a branch-b
```

### What does `git blame` do?

It shows the most recent commit and author responsible for each line. It is
useful for context, not assigning personal blame.

### What does `git show` do?

It displays a Git object, commonly a commit's metadata and patch:

```bash
git show <commit-hash>
```

### What does `git clean` do?

It removes untracked files:

```bash
git clean -n   # preview
git clean -fd  # remove untracked files and directories
```

Always preview first because removed untracked files are not recoverable through
Git.

## 17. Rapid-Fire Interview Answers

### Can Git work without internet?

Yes. Local commits, branches, diffs, logs, merges, and rebases work offline.
Network access is needed for remote operations.

### Can two branches point to the same commit?

Yes. Branches are independent references and may point to the same commit.

### Can a commit have multiple parents?

Yes. A normal merge commit has two parents. Octopus merges can have more.

### Does deleting a branch delete commits immediately?

No. Commits reachable from other references remain. Unreachable commits may
still be recoverable from reflog until eventually garbage-collected.

### Can a tag move?

Technically yes, but published release tags should be treated as immutable.
Moving them harms release trust and reproducibility.

### Why are small commits useful?

They are easier to review, revert, cherry-pick, test, and understand.

### Why keep the working tree clean?

It reduces accidental commits, makes branch switching safer, and makes
diagnostics clearer.

### Why inspect before force-pushing?

Force pushes rewrite remote branch history and may remove collaborators' work.
Fetch first and use `--force-with-lease`.

### Which is safer on shared branches: revert or reset?

Revert, because it adds history instead of rewriting existing shared history.

### What should you run first when Git behaves unexpectedly?

```bash
git status
```

It usually explains the current branch, pending operation, conflicts, staged
changes, and recommended next commands.

## 18. Recommended Interview Explanation Structure

For scenario questions, answer in this order:

1. State the current risk.
2. Inspect safely (`git status`, `git log`, `git reflog`, `git diff`).
3. Protect existing work with a branch, commit, or stash.
4. Apply the least destructive solution.
5. Verify history and tests.
6. Push through review and CI.
7. Explain prevention through branch protection or team policy.

This demonstrates both Git knowledge and production-safety judgment.

