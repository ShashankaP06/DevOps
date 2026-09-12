# 02 — Git & GitHub Beyond Basics

**Est. time:** 3-4 weeks @ 2-5 hrs/week
**Status:** 🔲 Not started

## Why this matters for you

You already use Git for release tagging/versioning. This module fills the
gaps: branching strategies, resolving real conflicts, and collaborating via
pull requests — all daily DevOps skills.

## Topics Checklist

- [ ] Branching strategies (Git Flow, trunk-based development, feature branches)
- [ ] Rebasing vs merging — when to use which
- [ ] Resolving merge conflicts confidently (not just accepting a side blindly)
- [ ] Interactive rebase (`git rebase -i`) to clean up commit history
- [ ] `git bisect` to find a breaking commit
- [ ] `git stash`, `git cherry-pick`, `git reflog` (recovering "lost" commits)
- [ ] Writing good commit messages / PR descriptions
- [ ] Protected branches, required reviews, CODEOWNERS
- [ ] Semantic versioning + git tags for releases (you likely know this already)

## Free Resources

- [Learn Git Branching](https://learngitbranching.js.org/) — interactive, does the whole topic justice in a few hours
- [Pro Git book](https://git-scm.com/book/en/v2) (free) — chapters 3, 5, 7
- [GitHub Skills](https://skills.github.com/) — "Introduction to GitHub", "Resolving merge conflicts"

## Hands-on Mini Project

Create a small repo (or use this one) and deliberately:
1. Create two branches that edit the same line of a file — merge them and
   practice resolving the conflict manually.
2. Make 4-5 messy commits, then `git rebase -i` to squash/reword them into a
   clean history.
3. Open a PR to yourself (or a friend) and practice a code review.

Document what you did in a `NOTES.md` in this folder, with commands used.
