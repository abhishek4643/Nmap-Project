# Engineering Rules & Scripting Standards
### Automated Network Reconnaissance Tool — Bash Standards, Security Directives, and Code Hygiene

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=12,20,26&height=8&section=header&width=100%" width="100%" />
</div>

---

## 1. Core Scripting Directives

All modifications to scripts within the **Automated Network Reconnaissance Tool** repository must strictly follow these engineering and security standards.

---

## 2. GNU Bash Quality & ShellCheck Standards

### 2.1 Variable Quoting & Word Splitting
- **Mandatory Quoting:** Always wrap variable expansions in double quotes (e.g., `"$target"`, `"$filename"`, `"$output"`) to prevent unintended word splitting and filename globbing.
- **Path Resolution:** Always quote file system paths and avoid relative assumptions without resolving the script's directory.

### 2.2 ShellCheck Linter Compliance
- All Bash scripts must pass **ShellCheck** without warnings or errors.
- Never disable ShellCheck directives globally; localized `# shellcheck disable=SCxxxx` comments require explicit justification in the commit message.

### 2.3 Strict Error Handling & Exit Traps
- Scripts must handle interrupt signals (`SIGINT`, `SIGTERM`) gracefully using `trap`:
  ```bash
  cleanup() {
      echo -e "\n[!] Scan interrupted by user. Cleaning up..."
      exit 130
  }
  trap cleanup SIGINT SIGTERM
  ```
- Functions must explicitly return exit status codes (`return 0` for success, non-zero for failures).

---

## 3. Security & Operational Safety Directives

### 3.1 Input Validation & Command Injection Prevention
- **Strict Parameter Sanitization:** The `--target` argument must be validated against safe IP or domain character sets prior to passing to subshells.
- Never pass unvalidated user inputs directly to `eval` or backtick subshells.

### 3.2 Privilege Management
- Scripts must explicitly warn when executed without root privileges if the requested mode invokes SYN scans (`-sS`) or OS detection (`-O`).
- Fall back gracefully to unprivileged TCP Connect scans (`-sT`) when root capabilities (`cap_net_raw`) are unavailable.

### 3.3 Output File Integrity & Permissions
- Output files must be created with secure file permissions (`chmod 600` or `chmod 640`) to prevent unauthorized reading of network topology maps.
- Do not log sensitive credential parameters to world-readable temporary directories (`/tmp`).

---

## 4. Function & Code Organization

### 4.1 Modularity & Single Responsibility
- Every operational action must be encapsulated in a dedicated function (e.g., `display_banner`, `display_help`, `run_quick_scan`, `run_normal_scan`, `run_full_scan`).
- Main execution flow must be orchestrated at the bottom of the script inside a clean `main` or case evaluation block.

### 4.2 Standard Output Standards
- Use `echo -e` with consistent color indicators:
  - Green (`\033[0;32m`): Successful state or open port notification.
  - Yellow (`\033[0;33m`): Warning or non-fatal condition.
  - Red (`\033[0;31m`): Error or fatal abort condition.
  - Reset (`\033[0m`): Terminal style reset after every formatted output.

---

## 5. Repository & Version Control Hygiene

- **File Permissions:** Ensure executable scripts maintain the executable bit (`chmod +x scan.sh`).
- **No Residual Artifacts:** Never commit output `.txt` or `.xml` scan reports from live engagements to the repository. The `.gitignore` must exclude `*.txt`, `*.xml`, and temporary scan logs.
