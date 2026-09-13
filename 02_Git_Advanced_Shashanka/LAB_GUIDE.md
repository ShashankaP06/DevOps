# Git Advanced — Hands-On Lab Guide

Follow these labs in order. Each one is self-contained, uses a throwaway
practice repo (so you can't break anything real), and maps directly to the
checklist in `README.md`. Copy-paste the commands into a terminal (Git Bash,
WSL, or PowerShell with Git for Windows all work fine — no Linux required
for this module).

Set up a scratch repo once, used across all labs:

```bash
cd /mnt/c/Users/VPALLSH/Desktop/DevOps/02_Git_Advanced_Shashanka
mkdir -p practice_repo && cd practice_repo
git init
git config user.email "you@example.com"
git config user.name "Shashanka"
echo "line 1" > file.txt
git add file.txt
git commit -m "Initial commit"
```

---

## Lab 1 — Branching + Resolving a Real Merge Conflict

```bash
# Branch A changes line 1
git checkout -b feature-a
echo "line 1 - changed by feature-a" > file.txt
git commit -am "feature-a: update line 1"

# Branch B changes the same line, from main
git checkout main
git checkout -b feature-b
echo "line 1 - changed by feature-b" > file.txt
git commit -am "feature-b: update line 1"

# Merge feature-a into main first (clean merge)
git checkout main
git merge feature-a

# Now merge feature-b -> CONFLICT, because main and feature-b both changed
# the same line differently
git merge feature-b
```

Git will report a conflict in `file.txt`. Open it — you'll see conflict
markers like:

```
<<<<<<< HEAD
line 1 - changed by feature-a
=======
line 1 - changed by feature-b
>>>>>>> feature-b
```

Manually edit the file to the resolution you want (e.g. combine both lines
or pick one), remove the `<<<<<<<`/`=======`/`>>>>>>>` markers, then:

```bash
git add file.txt
git commit -m "Merge feature-b, resolve conflict on line 1"
git log --oneline --graph --all
```

**What to note in NOTES.md:** what the conflict markers looked like, and
exactly how you decided to resolve it.

---

## Lab 2 — Interactive Rebase (Cleaning Up Messy History)

```bash
git checkout -b messy-feature main
echo "step 1" >> notes.txt && git add notes.txt && git commit -m "wip"
echo "step 2" >> notes.txt && git commit -am "wip again"
echo "step 3" >> notes.txt && git commit -am "fix typo"
echo "step 4" >> notes.txt && git commit -am "actually finish this"

git log --oneline   # you'll see 4 messy commits
```

Now clean them into one well-described commit:

```bash
git rebase -i HEAD~4
```

In the editor that opens, change `pick` to `squash` (or `s`) on the last 3
lines, save and close. On the next screen, write one clean commit message
(e.g. "Add notes.txt with 4 lines of content"), save and close.

```bash
git log --oneline   # now just 1 clean commit
```

**What to note in NOTES.md:** before/after `git log --oneline` output.

---

## Lab 3 — Stash, Cherry-Pick, Reflog

```bash
# Stash: save uncommitted work without committing
git checkout main
echo "half-finished idea" >> file.txt
git stash
git status                # working tree clean again
git stash pop              # bring the change back

# Cherry-pick: grab one specific commit onto another branch
git log --oneline messy-feature       # note a commit hash from here
git checkout main
git cherry-pick <that-commit-hash>

# Reflog: "undo" a mistake, e.g. an accidental hard reset
git reset --hard HEAD~1    # oops, simulate losing a commit
git reflog                 # find the commit hash from before the reset
git reset --hard <hash-from-reflog>   # recover it
```

**What to note in NOTES.md:** the reflog output and how you identified the
right commit to recover.

---

## Lab 4 — Git Bisect (Finding a Breaking Commit)

```bash
git checkout main
for i in 1 2 3 4 5; do
  echo "version $i, still fine" >> app.txt
  git add app.txt
  git commit -m "release v$i"
done
# Introduce a "bug" partway through history on purpose
echo "BROKEN" >> app.txt
git commit -am "release v6 (secretly broken)"
echo "version 7, fine again" >> app.txt
git commit -am "release v7"

git bisect start
git bisect bad                 # current commit is "bad"
git bisect good HEAD~6          # a commit near the start was "good"
# Git checks out a midpoint commit. Inspect app.txt each time:
cat app.txt
# If it contains "BROKEN", run: git bisect bad
# Otherwise run: git bisect good
# Repeat until git reports the exact first bad commit
git bisect reset
```

**What to note in NOTES.md:** which commit `git bisect` identified as the
first bad one, and how many steps it took.

---

## Lab 5 — Pull Request Practice (on GitHub)

1. Push `practice_repo` to a throwaway GitHub repo (or use a branch on
   `DevOps` itself if you'd rather not create a new repo).
2. Open a PR from `messy-feature` (or any branch) into `main`.
3. Add a description explaining what changed and why.
4. Leave at least one review comment on your own PR (GitHub allows this),
   then resolve it and merge.

**What to note in NOTES.md:** a link to the PR, and what you wrote in the
description.

---

## Wrap-up

Once all 5 labs are done, fill in `NOTES.md` (template provided in this
folder), update the status in the root `README.md` table to ✅, and tell
your assistant — it'll commit/push and move you on to Module 03.
