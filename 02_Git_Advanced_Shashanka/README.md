# 02 — Git & GitHub Beyond Basics

**Est. time:** 3-4 weeks @ 2-5 hrs/week
**Status:** 🟡 Labs complete — pull request pending

## Interview Preparation

See [`GIT_INTERVIEW_GUIDE.md`](./GIT_INTERVIEW_GUIDE.md) for Git concepts,
commands, troubleshooting scenarios, and interview answers from fundamentals
through advanced DevOps workflows.

## Why this matters for you

You already use Git for release tagging/versioning. This module fills the
gaps: branching strategies, resolving real conflicts, and collaborating via
pull requests — all daily DevOps skills.

## Topics Checklist

- [x] Branching strategies (feature branches practiced; Git Flow and trunk-based reviewed)
- [x] Rebasing vs merging — when to use which
- [x] Resolving merge conflicts confidently (not just accepting a side blindly)
- [x] Interactive rebase (`git rebase -i`) to clean up commit history
- [x] `git bisect` to find a breaking commit
- [x] `git stash`, `git cherry-pick`, `git reflog` (recovering "lost" commits)
- [x] Writing good commit messages / PR descriptions
- [ ] Protected branches, required reviews, CODEOWNERS
- [x] Semantic versioning + git tags for releases (concept reviewed)

## Free Resources

- [Learn Git Branching](https://learngitbranching.js.org/) — interactive, does the whole topic justice in a few hours
- [Pro Git book](https://git-scm.com/book/en/v2) (free) — chapters 3, 5, 7
- [GitHub Skills](https://skills.github.com/) — "Introduction to GitHub", "Resolving merge conflicts"

## Hands-on Mini Project

The exercises were run in an independent WSL repository at
`~/git-advanced-practice`. Genuine command output and final files are stored in
`evidence/` so they can be reviewed on GitHub without nesting a repository.

Completed exercises:
1. Create two branches that edit the same line of a file — merge them and
   practice resolving the conflict manually.
2. Make 4-5 messy commits, then `git rebase -i` to squash/reword them into a
   clean history.
3. Practice stash, cherry-pick, reflog recovery, and automated `git bisect`.
4. Open a real PR for the completed module evidence.

See `NOTES.md` for the walkthrough and `LAB_GUIDE.md` for the lab instructions.
