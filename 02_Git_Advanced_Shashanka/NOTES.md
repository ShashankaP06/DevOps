# Notes - Git Advanced (Module 02)

Fill this in as you work through `LAB_GUIDE.md`.

## Lab 1 - Branching + Merge Conflict

- Commands run:
  ```
  git init
  git config user.email "my-email@example.com"
  git config user.name "Shashanka"
  echo "line 1" > file.txt
  git add file.txt
  git commit -m "Initial commit"
  git branch -m main

  git checkout -b feature-a
  echo "line 1 - changed by feature-a" > file.txt
  git commit -am "feature-a: update line 1"

  git checkout main
  git merge feature-a

  git checkout -b feature-b
  echo "line 1 - changed by feature-b" > file.txt
  git commit -am "feature-b: update line 1"

  git checkout main
  git merge feature-b   # <-- conflict happened here

  # edited file.txt by hand to resolve
  git add file.txt
  git commit             # opened editor for the merge commit message

  git log --oneline --graph --all
  ```

- What the conflict markers looked like:
  ```
  <<<<<<< HEAD
  line 1 - changed by feature-a
  =======
  line 1 - changed by feature-b
  >>>>>>> feature-b
  ```
  (`HEAD` = current branch's version, i.e. what `main` already had. The
  incoming branch being merged in, `feature-b`, is shown below the
  `=======` divider.)

- How I resolved it and why:
  Git couldn't auto-merge because both branches changed the exact same
  line of `file.txt` in different ways, so it couldn't guess which one I
  wanted. I opened `file.txt`, deleted the `<<<<<<<`, `=======`, and
  `>>>>>>>` marker lines, and replaced the two conflicting lines with one
  combined line: `line 1 - merged from feature-a and feature-b`. Then
  `git add file.txt` told Git "this conflict is resolved", and
  `git commit` created a merge commit tying both branch histories
  together. `git log --oneline --graph --all` then showed the two
  branches diverging and joining back into a single point, confirming
  the merge worked.

## Lab 2 - Interactive Rebase

- `git log --oneline` before:
  ```
  e6575d2 finally done
  f949787 fix stuff
  6359d32 wip again
  0bf123b wip
  ba6626a Add rebase practice baseline
  ```
- Command used: `git rebase -i HEAD~4`
- The first commit was kept with `pick`; the next three were changed to
  `squash`, combining all four changes into one commit.
- `git log --oneline` after:
  ```
  49c3fcc Add complete rebase practice feature
  ba6626a Add rebase practice baseline
  ```
- Final squashed commit message: `Add complete rebase practice feature`
- Evidence: `evidence/command-output/lab2-before.txt` and
  `evidence/command-output/lab2-after.txt`

## Lab 3 - Stash, Cherry-Pick, Reflog

- Stash: I modified `notes.txt`, ran `git stash push`, and confirmed the
  working tree became clean. `git stash pop` restored the modification and
  removed that stash entry.
- Cherry-pick: commit `fa092dd` was created on `cherry-source` and copied
  onto `lab3-practice` with `git cherry-pick`.
- Reflog: commit `7b96a0d` was removed using `git reset --hard HEAD~1`.
  `git reflog` still showed the previous commit, so
  `git reset --hard 7b96a0d` recovered it and `recover.txt`.
- Evidence: `evidence/command-output/lab3-stash.txt`,
  `lab3-cherry-pick.txt`, and `lab3-reflog.txt`

## Lab 4 - Git Bisect

- `git bisect run` tested three revisions automatically.
- The exact first-bad commit was `759cd1f`:
  `Release v5 introduces regression`.
- The test script returned failure whenever `app.txt` contained `BROKEN`.
- Command used to confirm it: `git show --stat 759cd1f`
- Evidence: `evidence/command-output/lab4-bisect.txt`

## Lab 5 - Pull Request Practice

- This module's evidence and notes are being submitted through a real feature
  branch and GitHub pull request into `main`.
- PR link: https://github.com/ShashankaP06/DevOps/pull/2
- PR description: summarizes Labs 1-4, evidence files, and the isolated
  practice-repository approach.

## Overall takeaways

- Biggest "aha" moment: branches are pointers to commit histories, conflicts
  require a human decision, rebase can clean history, reflog can recover
  commits removed from a branch, and bisect performs a binary search through
  history to locate regressions.
- Practice repositories should not be nested inside the portfolio repository.
  Labs now run in `~/git-advanced-practice`; exportable evidence is stored here.
