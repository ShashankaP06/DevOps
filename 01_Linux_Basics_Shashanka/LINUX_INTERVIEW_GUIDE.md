# Linux Interview Guide for DevOps Engineers

This guide covers Linux concepts commonly asked in DevOps, cloud, release,
site-reliability, and platform-engineering interviews.

## 1. Linux Fundamentals

### What is Linux?

Linux is an open-source Unix-like kernel. A Linux distribution combines the
kernel with user-space tools, package management, libraries, and applications.

Common distributions include:

- Ubuntu and Debian.
- Red Hat Enterprise Linux, Rocky Linux, and AlmaLinux.
- Amazon Linux.
- SUSE Linux Enterprise.
- Alpine Linux.

### Kernel vs shell

- The **kernel** manages CPU, memory, processes, devices, filesystems, and
  networking.
- A **shell** accepts commands and launches programs.
- Bash, Zsh, and Fish are Unix shells.

### Linux vs Unix

Unix refers to an older family and specification of operating systems. Linux
was independently created with Unix-like behavior and interfaces.

### What is a terminal?

A terminal is the interface through which a user interacts with a shell. The
terminal and shell are different programs.

### What is WSL?

Windows Subsystem for Linux runs a Linux environment on Windows. WSL2 uses a
real Linux kernel in a lightweight virtual machine.

### How do you identify the operating system and kernel?

```bash
cat /etc/os-release
uname -a
uname -r
hostnamectl
```

## 2. Filesystem Structure

### Important Linux directories

- `/`: filesystem root.
- `/etc`: system configuration.
- `/home`: regular users' home directories.
- `/root`: root user's home.
- `/var`: changing data such as logs, cache, and application state.
- `/var/log`: system and application logs.
- `/tmp`: temporary files.
- `/usr`: installed programs, libraries, and shared data.
- `/bin` and `/sbin`: essential commands, often linked into `/usr`.
- `/dev`: device files.
- `/proc`: virtual process and kernel information.
- `/sys`: virtual hardware and kernel interface.
- `/boot`: bootloader and kernel files.
- `/mnt` and `/media`: mount points.
- `/opt`: optional third-party software.

### Absolute vs relative paths

- Absolute paths begin at `/`, such as `/var/log/syslog`.
- Relative paths begin from the current directory, such as `logs/app.log`.

### Useful navigation commands

```bash
pwd
ls -la
cd /var/log
cd ..
cd ~
cd -
```

### Meaning of `.`, `..`, and `~`

- `.`: current directory.
- `..`: parent directory.
- `~`: current user's home directory.

### Hidden files

Names beginning with `.` are hidden by convention:

```bash
ls -a
```

## 3. Files and Directories

### Common commands

```bash
touch file.txt
mkdir directory
mkdir -p parent/child
cp source destination
cp -r source-directory destination
mv old-name new-name
rm file.txt
rm -r directory
```

Use `rm -rf` carefully: it recursively and forcibly removes paths without a
normal recovery mechanism.

### Copy vs move

- `cp` creates another copy.
- `mv` relocates or renames the existing path.

### Hard links vs symbolic links

#### Hard link

```bash
ln original.txt hardlink.txt
```

- Points to the same inode/data.
- Usually cannot cross filesystems.
- Normally cannot link directories.
- Data remains while at least one hard link exists.

#### Symbolic link

```bash
ln -s /target/path shortcut
```

- Stores a target path.
- Can cross filesystems.
- Can link directories.
- Becomes broken if the target disappears.

### What is an inode?

An inode stores filesystem metadata such as ownership, permissions, timestamps,
file type, size, and data-block locations. The filename maps to an inode.

```bash
ls -li
stat file.txt
```

### Find files

```bash
find /var/log -name "*.log"
find . -type f -size +100M
find . -type f -mtime -7
find . -type f -perm 0777
```

### `find` vs `locate`

- `find` searches the live filesystem and supports detailed conditions.
- `locate` searches a prebuilt filename database and is faster but may be
  outdated.

## 4. Viewing and Processing Text

### View files

```bash
cat file.txt
less file.txt
head -n 20 file.txt
tail -n 20 file.txt
tail -f application.log
```

`less` is better than `cat` for long files because it supports scrolling and
searching.

### Search with grep

```bash
grep "ERROR" application.log
grep -i "error" application.log
grep -R "database" /etc/app/
grep -n "timeout" application.log
grep -v "healthcheck" access.log
grep -E "ERROR|WARN" application.log
```

Useful options:

- `-i`: case-insensitive.
- `-n`: show line numbers.
- `-R`: recursive.
- `-v`: invert the match.
- `-E`: extended regular expressions.
- `-A`, `-B`, `-C`: surrounding context.

### `awk`

`awk` processes column-oriented text:

```bash
awk '{print $1}' access.log
awk -F: '{print $1, $7}' /etc/passwd
awk '$5 > 1000 {print $1, $5}' data.txt
```

### `sed`

`sed` performs stream editing:

```bash
sed 's/old/new/' file.txt
sed 's/old/new/g' file.txt
sed -i 's/old/new/g' file.txt
sed -n '10,20p' file.txt
```

`-i` modifies the file in place; use it carefully or create a backup.

### `cut`, `sort`, `uniq`, and `wc`

```bash
cut -d: -f1 /etc/passwd
sort names.txt
sort names.txt | uniq
sort names.txt | uniq -c
wc -l application.log
```

### Pipes and redirection

```bash
command > output.txt      # overwrite standard output
command >> output.txt     # append standard output
command 2> errors.txt     # redirect standard error
command > all.txt 2>&1    # combine output and errors
command1 | command2       # pipe output into another command
```

Standard streams:

- `0`: standard input.
- `1`: standard output.
- `2`: standard error.

### `tee`

`tee` displays output and writes it to a file:

```bash
command | tee output.log
command | tee -a output.log
```

## 5. Users and Groups

### Root user

`root` is the administrative account with UID `0`. It can bypass most normal
permission checks.

### `sudo`

`sudo` runs an approved command with elevated privileges and normally records
the action in logs.

```bash
sudo systemctl restart nginx
sudo -l
```

Use the least privilege necessary instead of working permanently as root.

### Important account files

- `/etc/passwd`: account metadata, UID, GID, home, and shell.
- `/etc/shadow`: password hashes and password-aging information.
- `/etc/group`: group definitions.
- `/etc/sudoers`: sudo policy; edit using `visudo`.

### User-management commands

```bash
id
whoami
who
w
sudo useradd -m username
sudo passwd username
sudo usermod -aG group username
sudo userdel -r username
groups username
```

### Why use groups?

Groups provide manageable shared access. Permissions can be granted to a group
instead of individually to every user.

## 6. Permissions and Ownership

### Read permission notation

Example:

```text
-rwxr-xr--
```

- First character: file type (`-`, `d`, `l`, etc.).
- `rwx`: owner permissions.
- `r-x`: group permissions.
- `r--`: others' permissions.

### Numeric permissions

- Read = `4`.
- Write = `2`.
- Execute = `1`.

Examples:

```bash
chmod 644 file.txt
chmod 755 script.sh
chmod 700 private-script.sh
chmod 444 read-only.txt
```

### Directory permission meaning

For a directory:

- Read: list names.
- Write: create/delete entries.
- Execute: enter/traverse the directory.

Directory permissions therefore behave differently from regular-file
permissions.

### Change ownership

```bash
sudo chown user file.txt
sudo chown user:group file.txt
sudo chown -R user:group directory/
sudo chgrp group file.txt
```

### What is `umask`?

`umask` removes permissions from the default creation mode.

Common `022` behavior:

- Files usually become `644`.
- Directories usually become `755`.

```bash
umask
umask 027
```

### SUID, SGID, and sticky bit

- **SUID**: executable runs with file owner's effective identity.
- **SGID on executable**: runs with file group's effective identity.
- **SGID on directory**: new files inherit the directory's group.
- **Sticky bit**: users can delete only their own entries in shared directories.

Examples:

```bash
chmod u+s executable
chmod g+s shared-directory
chmod +t shared-directory
```

`/tmp` commonly has mode `1777`.

### ACLs

Access Control Lists provide permissions beyond owner/group/others:

```bash
getfacl file.txt
setfacl -m u:alice:rw file.txt
```

## 7. Processes

### What is a process?

A process is a running instance of a program with a process ID, memory, open
files, environment, security identity, and execution state.

### Inspect processes

```bash
ps aux
ps -ef
top
htop
pgrep nginx
pstree
```

### Foreground and background jobs

```bash
long-command &
jobs
fg %1
bg %1
Ctrl+Z
```

### Signals and terminating processes

```bash
kill <pid>
kill -TERM <pid>
kill -KILL <pid>
pkill nginx
killall process-name
```

- `SIGTERM` (`15`) requests graceful shutdown.
- `SIGKILL` (`9`) forces termination and cannot be handled.
- Try `TERM` before `KILL`.

### Zombie process

A zombie has finished execution, but its parent has not collected its exit
status. It consumes a process-table entry but not normal execution resources.

### Orphan process

An orphan's parent has exited. It is adopted by a system process such as
`systemd`.

### Process priorities

```bash
nice -n 10 command
renice 5 -p <pid>
```

Lower nice values mean higher CPU scheduling priority. Raising priority
normally requires privileges.

### Open files and process investigation

```bash
lsof
lsof -i :8080
ls -l /proc/<pid>/fd
cat /proc/<pid>/status
```

## 8. Services and systemd

### What is systemd?

`systemd` is the init and service manager used by many distributions. PID 1
starts and supervises services and system targets.

### Common commands

```bash
systemctl status nginx
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
sudo systemctl enable nginx
sudo systemctl disable nginx
systemctl is-active nginx
systemctl is-enabled nginx
```

### Restart vs reload

- Restart stops and starts the service, causing interruption.
- Reload asks a service to reread configuration without a full restart, when
  supported.

### Unit-file locations

Common locations:

- `/usr/lib/systemd/system` or `/lib/systemd/system`: packaged units.
- `/etc/systemd/system`: administrator-defined units and overrides.

After changing unit definitions:

```bash
sudo systemctl daemon-reload
```

### Service logs

```bash
journalctl -u nginx
journalctl -u nginx --since "1 hour ago"
journalctl -u nginx -f
journalctl -p err
```

## 9. Package Management

### Debian/Ubuntu

```bash
sudo apt update
sudo apt install nginx
sudo apt remove nginx
sudo apt upgrade
apt search nginx
dpkg -l
```

- `apt update` refreshes package metadata.
- `apt upgrade` installs available upgrades.

### RHEL-family systems

```bash
sudo dnf install nginx
sudo dnf remove nginx
sudo dnf update
rpm -qa
rpm -qf /path/to/file
```

Older environments may use `yum`.

### Why use a package manager?

It resolves dependencies, verifies packages, tracks installed files, handles
updates, and integrates trusted repositories.

## 10. Archives and Compression

### `tar`

```bash
tar -cvf archive.tar directory/
tar -xvf archive.tar
tar -czvf archive.tar.gz directory/
tar -xzvf archive.tar.gz
tar -cjvf archive.tar.bz2 directory/
tar -tf archive.tar
```

Common flags:

- `c`: create.
- `x`: extract.
- `v`: verbose.
- `f`: archive filename follows.
- `z`: gzip.
- `j`: bzip2.

### `zip`

```bash
zip -r archive.zip directory/
unzip archive.zip
unzip archive.zip -d destination/
```

### Archiving vs compression

- Archiving combines files into one container.
- Compression reduces size.
- `tar` archives; gzip/bzip2/xz compress.

## 11. Storage and Filesystems

### Check disk usage

```bash
df -h
du -sh directory/
du -h --max-depth=1 /var
lsblk
findmnt
```

- `df` reports filesystem capacity.
- `du` reports space used by paths.

### Disk is full but `du` does not explain it

Possible causes:

- Deleted files still held open by running processes.
- Reserved filesystem blocks.
- Mounted filesystems hiding underlying data.
- Inode exhaustion.

Useful checks:

```bash
lsof +L1
df -i
findmnt
```

### What is a mount?

Mounting attaches a filesystem to the directory tree:

```bash
sudo mount /dev/sdb1 /mnt/data
sudo umount /mnt/data
```

Persistent mounts are commonly configured in `/etc/fstab`.

### Why use UUIDs in `/etc/fstab`?

Device names such as `/dev/sdb1` may change. Filesystem UUIDs provide more
stable identification.

```bash
blkid
```

### LVM

Logical Volume Manager separates storage into:

- Physical volumes.
- Volume groups.
- Logical volumes.

It supports flexible allocation, extension, and snapshots.

Useful commands:

```bash
pvs
vgs
lvs
lvextend
```

Filesystem growth may require `resize2fs` or `xfs_growfs` after extending the
logical volume.

## 12. Memory and CPU

### Check memory

```bash
free -h
cat /proc/meminfo
vmstat 1
```

Linux uses unused memory for cache. Low "free" memory alone is not necessarily
a problem; examine "available" memory.

### What is swap?

Swap is disk space used when memory pressure requires moving less-active pages
out of RAM. It is much slower than RAM.

High sustained swap activity may indicate memory pressure:

```bash
swapon --show
vmstat 1
```

### Check CPU

```bash
top
mpstat
uptime
lscpu
```

### Load average

`uptime` displays average runnable or uninterruptible tasks over 1, 5, and 15
minutes. Interpret it relative to CPU count and investigate sustained growth.

Load is not exactly CPU percentage; I/O waits can contribute.

## 13. Networking

### Common diagnostic commands

```bash
ip addr
ip route
ping -c 4 host
curl -v https://example.com
wget https://example.com/file
ss -tulpn
dig example.com
nslookup example.com
traceroute example.com
```

Modern systems generally use `ip` instead of `ifconfig` and `ss` instead of
`netstat`.

### IP address, subnet, and gateway

- IP address identifies an interface.
- Subnet mask/prefix defines the local network range.
- Default gateway routes traffic to other networks.

### DNS resolution

DNS converts names to addresses. Useful checks:

```bash
getent hosts example.com
dig example.com
cat /etc/resolv.conf
resolvectl status
```

### Common ports

- SSH: `22`
- HTTP: `80`
- HTTPS: `443`
- DNS: `53`
- SMTP: `25`
- PostgreSQL: `5432`
- MySQL: `3306`
- Redis: `6379`
- Kubernetes API: `6443`

### TCP vs UDP

- TCP is connection-oriented, ordered, and reliable.
- UDP is connectionless with lower overhead and no built-in delivery guarantee.

### Listening ports

```bash
ss -lntp
sudo lsof -i :8080
```

### Troubleshoot "service unreachable"

Check in this order:

1. Is the process running?
2. Is it listening on the expected address and port?
3. Does local `curl` work?
4. Is DNS resolving correctly?
5. Is routing correct?
6. Are host/cloud firewalls allowing traffic?
7. Is a proxy, load balancer, VPN, or network policy involved?
8. What do application and system logs report?

## 14. SSH

### What is SSH?

SSH provides encrypted remote login, command execution, tunneling, and file
transfer.

```bash
ssh user@host
ssh -i key.pem user@host
scp file.txt user@host:/tmp/
rsync -avz directory/ user@host:/destination/
```

### SSH key authentication

```bash
ssh-keygen -t ed25519
ssh-copy-id user@host
```

- Private key remains secret.
- Public key is placed in the remote user's `~/.ssh/authorized_keys`.

Typical permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_ed25519
```

### Basic SSH hardening

- Prefer key authentication.
- Disable direct root login.
- Restrict allowed users/groups.
- Apply least privilege.
- Keep OpenSSH updated.
- Use network controls and monitoring.

## 15. Environment Variables and Shell Behavior

### Shell variable vs environment variable

```bash
MY_VAR="value"        # shell variable
export MY_VAR         # available to child processes
export MY_VAR="value"
```

Child processes inherit exported variables. A child cannot directly modify its
parent shell's environment.

### Display variables

```bash
echo "$MY_VAR"
printenv MY_VAR
env
```

Quote variable expansions unless intentional word splitting is required:

```bash
echo "$MY_VAR"
```

### `PATH`

`PATH` is a colon-separated list of directories searched for executable
commands:

```bash
echo "$PATH"
command -v python3
which python3
export PATH="$HOME/bin:$PATH"
```

### Startup files

Common Bash files:

- `~/.bashrc`: interactive non-login shells.
- `~/.profile` or `~/.bash_profile`: login-shell environment.
- `/etc/profile`: system-wide login configuration.

Exact behavior depends on how the shell is invoked.

### Exit codes

```bash
command
echo $?
```

- `0`: success.
- Non-zero: failure or another documented condition.

### `&&`, `||`, and `;`

```bash
command1 && command2  # run second only if first succeeds
command1 || command2  # run second only if first fails
command1 ; command2   # run second regardless
```

## 16. Bash Scripting

### Script header

```bash
#!/usr/bin/env bash
set -euo pipefail
```

- `-e`: exit when an unhandled command fails.
- `-u`: error on unset variables.
- `pipefail`: pipeline fails if any component fails.

These improve safety but require understanding of their edge cases.

### Variables and arguments

```bash
name="Shashanka"
echo "$name"
echo "$1"
echo "$#"
echo "$@"
```

- `$0`: script name.
- `$1`: first argument.
- `$#`: argument count.
- `"$@"`: all arguments while preserving boundaries.

### Conditionals

```bash
if [[ -f "$file" ]]; then
  echo "File exists"
else
  echo "File missing"
fi
```

### Loops

```bash
for file in *.log; do
  echo "$file"
done

while read -r line; do
  echo "$line"
done < input.txt
```

### Functions

```bash
check_service() {
  local service_name=$1
  systemctl is-active --quiet "$service_name"
}
```

### Why quote variables?

Without quotes, whitespace and wildcard characters can split or expand values,
causing incorrect or unsafe behavior.

Use:

```bash
rm -- "$filename"
```

instead of:

```bash
rm $filename
```

### ShellCheck

ShellCheck statically analyzes shell scripts for common bugs:

```bash
shellcheck script.sh
```

## 17. Scheduling

### Cron

User crontab:

```bash
crontab -e
crontab -l
```

Example:

```cron
0 2 * * * /home/user/backup.sh >> /var/log/backup.log 2>&1
```

Fields represent minute, hour, day of month, month, and day of week.

Cron uses a limited environment, so use absolute paths and explicitly define
required variables.

### systemd timers

Timers integrate with systemd services, dependency management, and journal
logging. They are often preferable for system-level scheduling.

## 18. Logs and Troubleshooting

### Common log locations

- `/var/log/syslog` on many Debian/Ubuntu systems.
- `/var/log/messages` on many RHEL systems.
- `/var/log/auth.log` or `/var/log/secure`.
- Application-specific directories.
- systemd journal.

### Follow a log

```bash
tail -f /var/log/application.log
journalctl -u service-name -f
```

### General troubleshooting method

1. Define the symptom and impact.
2. Identify when it started and what changed.
3. Check service/process status.
4. Inspect logs.
5. Check CPU, memory, disk, and inodes.
6. Check listening ports, DNS, routes, and firewalls.
7. Reproduce safely.
8. Apply the least risky fix.
9. Verify recovery.
10. Document cause and prevention.

### Server is slow

Check:

```bash
uptime
top
free -h
vmstat 1
iostat
df -h
df -i
ps aux --sort=-%cpu
ps aux --sort=-%mem
```

Determine whether the constraint is CPU, memory, disk I/O, storage, network, or
an application dependency.

### Service will not start

```bash
systemctl status service
journalctl -u service --since "15 minutes ago"
systemctl cat service
```

Then validate configuration, permissions, ports, dependencies, environment
variables, and disk space.

### Deleted log still consumes disk

A process may still hold the deleted file open:

```bash
lsof +L1
```

Restart or signal the responsible service safely so it closes the descriptor.

### "Permission denied"

Check:

```bash
id
namei -l /full/path/to/file
ls -ld /full /full/path /full/path/to /full/path/to/file
getfacl /full/path/to/file
```

Remember that execute permission is required on every parent directory for
traversal.

### Command not found

Check:

```bash
command -v command-name
echo "$PATH"
```

The package may be absent, the executable may not be in `PATH`, or the name may
be incorrect.

## 19. Security

### Principle of least privilege

Users, services, and automation should receive only the permissions required
for their function.

### Basic host-security practices

- Patch systems regularly.
- Use key-based SSH.
- Disable unnecessary services.
- Restrict inbound and outbound network access.
- Avoid running applications as root.
- Protect secrets and private keys.
- Centralize logs and monitor suspicious activity.
- Use mandatory-access controls when appropriate.

### SELinux

SELinux applies label-based mandatory access control:

```bash
getenforce
sestatus
ls -Z
ausearch -m AVC
```

Do not disable SELinux as the first fix. Diagnose the denied operation and
apply the correct context or policy.

### AppArmor

AppArmor restricts applications using path-based profiles and is common on
Ubuntu:

```bash
aa-status
```

### Firewalls

Common tools:

```bash
sudo ufw status
sudo firewall-cmd --list-all
sudo nft list ruleset
```

Cloud security groups and network ACLs may also affect connectivity.

### Secret exposed in a file

1. Revoke or rotate it immediately.
2. Remove it from the current configuration.
3. Store it in an approved secret manager.
4. Assess logs and access.
5. Rewrite repository history if required, but do not treat rewriting as a
   replacement for rotation.

## 20. Containers and Linux

### Containers vs virtual machines

- VMs virtualize hardware and run separate kernels.
- Containers isolate processes while sharing the host kernel.

Linux container isolation relies on:

- Namespaces for isolated views of resources.
- Control groups for resource limits/accounting.
- Capabilities for divided root privileges.
- Filesystem layers and security controls.

### Namespaces

Examples include PID, network, mount, user, IPC, UTS, and cgroup namespaces.

### Control groups

cgroups constrain and measure resources such as CPU and memory.

### Why containers can run as root but still be risky

Root inside a container may map to powerful host privileges depending on user
namespaces, mounts, capabilities, and runtime configuration. Prefer non-root
users and minimal capabilities.

## 21. Boot Process

Simplified boot sequence:

1. Firmware (BIOS/UEFI) initializes hardware.
2. Bootloader such as GRUB loads the kernel and initramfs.
3. Kernel initializes devices and mounts the initial root filesystem.
4. The init system, commonly systemd as PID 1, starts services and targets.
5. Login services become available.

Useful commands:

```bash
dmesg
journalctl -b
systemd-analyze
systemd-analyze blame
```

## 22. DevOps Interview Scenarios

### Deployment script works manually but fails in CI

Check:

- Different user and permissions.
- Working directory.
- Missing environment variables.
- Reduced `PATH`.
- Non-interactive shell behavior.
- Missing packages or credentials.
- Line endings and executable permission.
- Network/proxy restrictions.

Use explicit paths, controlled environments, clear logging, and strict error
handling.

### Shell script reports `$'\r': command not found`

The file likely uses Windows CRLF line endings. Convert to LF:

```bash
sed -i 's/\r$//' script.sh
dos2unix script.sh
```

Prevent recurrence with:

```gitattributes
*.sh text eol=lf
```

### Application works locally but not remotely

Check whether it listens only on `127.0.0.1` instead of `0.0.0.0`, then inspect
host firewall, cloud security groups, routing, load balancer health, TLS, and
DNS.

### CPU is high

```bash
top
ps aux --sort=-%cpu
pidstat
```

Identify the process and workload before restarting it. Examine recent changes,
logs, traffic, loops, and dependency behavior.

### Memory is exhausted

```bash
free -h
ps aux --sort=-%mem
vmstat 1
dmesg | grep -i oom
```

Check for OOM kills, leaks, incorrect limits, cache behavior, and workload
growth.

### Disk usage reaches 100%

```bash
df -h
df -i
du -xhd1 / | sort -h
lsof +L1
```

Avoid blindly deleting unknown files. Identify logs, caches, artifacts, deleted
open files, or inode exhaustion, then apply safe retention and monitoring.

### DNS fails in a server or container

Compare:

```bash
ip route
cat /etc/resolv.conf
getent hosts example.com
dig example.com
curl -v https://example.com
```

Determine whether failure is name resolution, routing, proxying, firewalling,
or the remote service itself.

### Configuration changed but service behavior did not

Verify:

- Correct file and environment.
- Syntax validation.
- Whether reload or restart is required.
- Runtime command-line arguments.
- Configuration precedence.
- Container/image actually deployed.

### Make a script idempotent

An idempotent script can run repeatedly without creating unintended additional
changes. Check existing state before creating users, directories, packages, or
configuration, and replace controlled content instead of appending repeatedly.

## 23. Rapid-Fire Interview Answers

### Why is Linux common in DevOps?

It dominates cloud servers and containers, provides strong automation tools,
offers transparent system interfaces, and integrates well with open-source
infrastructure software.

### What command should you run first during troubleshooting?

There is no universal single command. Start by clarifying the symptom, then use
targeted status and log commands. For a service, `systemctl status` and
`journalctl` are strong first checks.

### `chmod` vs `chown`

- `chmod` changes permission bits.
- `chown` changes owner and/or group.

### `df` vs `du`

- `df` reports filesystem-level allocation.
- `du` totals visible files under paths.

### `ps` vs `top`

- `ps` provides a point-in-time process listing.
- `top` provides a continuously updating interactive view.

### `kill -15` vs `kill -9`

- `15` requests graceful termination.
- `9` immediately forces termination and prevents cleanup.

### `apt update` vs `apt upgrade`

- `update` refreshes package metadata.
- `upgrade` installs newer package versions.

### `curl` vs `wget`

- `curl` is excellent for API requests and transferring data across many
  protocols.
- `wget` focuses on downloading files and supports recursive retrieval.

### `>` vs `>>`

- `>` overwrites.
- `>>` appends.

### Hard link vs symlink

- Hard links reference the same inode.
- Symlinks store another path.

### Why does `sudo` ask for your password rather than root's?

It authenticates the invoking user and checks whether sudo policy authorizes
that user.

### Why avoid running applications as root?

A compromised application would gain broad system control. A dedicated,
least-privileged account limits impact.

### What does executable permission mean on a script?

It allows direct execution when the script has a valid interpreter line. The
interpreter also needs permission to read the script.

## 24. Recommended Interview Answer Structure

For troubleshooting questions:

1. Clarify symptoms, impact, scope, and recent changes.
2. Inspect before changing anything.
3. Check logs and service state.
4. Check resource and network dependencies.
5. Form and test one hypothesis at a time.
6. Apply the safest reversible fix.
7. Verify service and business-level recovery.
8. Add monitoring, automation, or process improvements to prevent recurrence.

This demonstrates Linux knowledge together with production judgment.

