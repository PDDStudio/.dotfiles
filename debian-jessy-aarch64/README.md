##debian-jessy-aarch64

This directory contains several dotfiles, configurations, scripts and patches which I'm using on my bootstrapped debian (jessy) aarch64 system.

###ToC
- Patch: Support Linuxbrew on aarch64


###Patch: Support Linuxbrew on aarch64

This patch adds support for

- `libc.so.6`
- `ld.so` 

lookup in `/lib/aarch64-linux-gnu/` when running `brew` on 64bit ARM devices.

**Oneliner (requires `wget` and `git`):**

```bash
sh -c "$(wget https://raw.githubusercontent.com/PDDStudio/.dotfiles/master/debian-jessy-aarch64/apply_patch_linuxbrew_aarch64.sh -O -)"
```
**Manually:**

```bash
# cd into linuxbrew's root directory
cd ~/.linuxbrew
# download the patch
wget https://raw.githubusercontent.com/PDDStudio/.dotfiles/master/debian-jessy-aarch64/support_aarch64.patch
# validate the patch
git apply --check support_aarch64.patch
# if no errors occurred - apply the patch
git am --signoff < support_aarch64.patch
```