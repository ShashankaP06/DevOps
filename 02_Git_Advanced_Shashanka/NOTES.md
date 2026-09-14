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
  line 1 - changed by feature-b
  =======
  line 1 - changed by feature-a
  >>>>>>> feature-a
  ```
  (`HEAD` = current branch's version, i.e. what `main` already had. The
  incoming branch being merged in, `feature-a`, is shown below the
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
- `git log --oneline` after:
- Final squashed commit message:

## Lab 3 - Stash, Cherry-Pick, Reflog

- Stash: what happened when I ran `git stash` / `git stash pop`:
- Cherry-pick: commit hash picked, and result:
- Reflog: how I found and recovered the "lost" commit:

## Lab 4 - Git Bisect

- Number of steps bisect took:
- The exact commit it identified as first-bad:
- Command used to confirm it: `git show <hash>`

## Lab 5 - Pull Request Practice

- PR link:
- PR description written:
- Review comment left + how it was resolved:

## Overall takeaways

- Biggest "aha" moment this module:
- Anything still confusing / to revisit later:
