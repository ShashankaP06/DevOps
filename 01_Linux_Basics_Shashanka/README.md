# 01 — Linux Basics — Shashanka

Practice project covering essential Linux command-line operations: file/directory
management, viewing files, searching, archiving, downloading, permissions, and
environment variables. Built for the Tutedude Linux Basics assignment.

This folder lives inside the [`DevOps`](https://github.com/ShashankaP06/DevOps)
repository, at `DevOps/01_Linux_Basics_Shashanka`.

## Project Structure

```
01_Linux_Basics_Shashanka/
├── scripts/
│   ├── 01_create_rename.sh   # Task 1: mkdir, touch, mv
│   ├── 02_view_files.sh      # Task 2: cat, head, tail
│   ├── 03_search_grep.sh     # Task 3: grep
│   ├── 04_zip_unzip.sh       # Task 4: zip, unzip
│   ├── 05_download.sh        # Task 5: wget
│   ├── 06_permissions.sh     # Task 6: chmod
│   ├── 07_env_vars.sh        # Task 7: export
│   └── run_all.sh            # Runs every task in order + logs output
├── Documentation_Linux_Basics_Shashanka.rtf   # Full write-up with screenshots
├── HOW_TO_RUN.md              # WSL setup + run + zip instructions
├── output_log.txt             # Generated after you run run_all.sh
└── README.md
```

## Quick Start

1. Open a Linux terminal (WSL, a Linux VM, or a cloud shell).
2. `cd` into this folder.
3. Run all tasks: `bash scripts/run_all.sh`
4. Screenshot each task's terminal output and paste it into
   `Documentation_Linux_Basics_Shashanka.rtf` in the matching placeholder.

See `HOW_TO_RUN.md` for full step-by-step setup instructions (including
installing WSL if you don't have a Linux environment yet).

## Tasks Covered

1. Creating and Renaming Files/Directories (`mkdir`, `touch`, `mv`)
2. Viewing File Contents (`cat`, `head`, `tail`)
3. Searching for Patterns (`grep`)
4. Zipping and Unzipping (`zip`, `unzip`)
5. Downloading Files (`wget`)
6. Changing Permissions (`chmod`)
7. Working with Environment Variables (`export`)

## Author

Shashanka

## GitHub Repository

https://github.com/ShashankaP06/DevOps/tree/main/01_Linux_Basics_Shashanka
