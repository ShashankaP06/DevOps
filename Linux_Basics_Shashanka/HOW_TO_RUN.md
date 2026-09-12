# How to Run This Project, Capture Screenshots, and Zip It

You said you don't currently have a Linux environment set up. The fastest path
on Windows 10/11 is **WSL (Windows Subsystem for Linux)** — free, built into
Windows, takes about 5-10 minutes to install.

## 1. Install WSL (Ubuntu)

Open **PowerShell as Administrator** and run:

```powershell
wsl --install
```

- This installs Ubuntu by default. Restart your PC if prompted.
- After restart, an Ubuntu window will open and ask you to create a
  UNIX username/password (can be anything, doesn't need to match Windows).
- If `wsl --install` doesn't work (older Windows build), install "Ubuntu"
  manually from the Microsoft Store instead, then launch it once to finish setup.

Once installed, you can always reopen it later by running `wsl` in
PowerShell/Command Prompt, or searching "Ubuntu" in the Start menu.

## 2. Get this project folder into WSL

Your Windows files are reachable from inside WSL under `/mnt/c/...`.
This project now lives inside the `DevOps` repo on your Desktop:

```bash
cd /mnt/c/Users/VPALLSH/Desktop/DevOps/Linux_Basics_Shashanka
ls
```

You should see the `scripts/` folder and this file.

## 3. Install the couple of tools Ubuntu doesn't ship with by default

```bash
sudo apt update
sudo apt install -y zip unzip wget
```

(`grep`, `cat`, `head`, `tail`, `mkdir`, `mv`, `chmod`, `export` are already
built in — no install needed.)

## 4. Run every task

```bash
bash scripts/run_all.sh
```

This runs Tasks 1–7 in order and prints each command + its output, and also
saves everything to `output_log.txt`.

**For Task 7 (environment variables)**, also type these two lines directly
into your terminal afterwards (not just via the script) so the screenshot
shows a live, interactive demo:

```bash
export MY_VAR="Hello, Linux!"
echo $MY_VAR
```

## 5. Take real screenshots

- **Windows + Shift + S** opens the Snipping Tool to capture a region of your
  screen (works fine capturing a WSL/Ubuntu window).
- Take one screenshot per task (or per command, for extra thoroughness)
  showing the command and its output together.
- Save them anywhere temporarily (e.g. Desktop), then paste each one into the
  matching placeholder inside `Documentation_Linux_Basics_Shashanka.rtf`
  (open it in Microsoft Word or Google Docs — Word will open the .rtf
  directly; for Google Docs, open Word first and use File > Save As Google
  Docs, or just File > Open and upload the .rtf).

## 6. Commit and push your screenshots back

After editing the `.rtf` with your screenshots (and letting `run_all.sh`
generate `output_log.txt`, `test_dir/`, etc.), you can push the updates from
WSL:

```bash
cd /mnt/c/Users/VPALLSH/Desktop/DevOps
git add Linux_Basics_Shashanka
git commit -m "Add screenshots to Linux Basics documentation"
git push
```

(Or just tell your assistant to do it — it can push via its git tooling.)

## 7. Zip the final submission folder

You do **not** need Linux for this — do it directly in Windows:

1. Right-click the `Linux_Basics_Shashanka` folder (inside `Desktop\DevOps`).
2. Choose **Send to > Compressed (zipped) folder**.
3. This creates `Linux_Basics_Shashanka.zip` right next to it.
4. Double check the zip contains: `scripts/`, `README.md`, `HOW_TO_RUN.md`,
   `Documentation_Linux_Basics_Shashanka.rtf`, and (after you run the script)
   `output_log.txt`, `test_dir/`, `test_dir.zip`, `unzipped_dir/`,
   `sample.txt`, `secure.txt`.
5. GitHub repository link for the submission portal:
   https://github.com/ShashankaP06/DevOps/tree/main/Linux_Basics_Shashanka
