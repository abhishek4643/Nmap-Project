# Project Memory & Context State
### Automated Network Reconnaissance Tool — Architecture State, Operational Invariants, and Knowledge Base

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=12,20,26&height=8&section=header&width=100%" width="100%" />
</div>

---

### Session Status

- **Active Milestone:** Production Release & Security Automation Standard
- **Stability Index:** 100% Operational
- **Target Environment:** GNU Bash 4.x+ / Nmap 7.x+
- **Supported Operating Systems:** Linux (Debian, Ubuntu, Kali, Arch), macOS, Unix
- **Documentation Suite:** Complete 6-File Engineering Documentation Standard

---

## 1. High-Level Architectural Context

The **Automated Network Reconnaissance Tool** was developed to bridge the gap between ad-hoc, manual Nmap command execution and enterprise-grade, reproducible reconnaissance workflows. By providing a clean CLI abstraction layer over Nmap's raw network probing capabilities, it allows security teams to rapidly assess attack surfaces, identify exposed ports, and export audit-ready evidence in plaintext and XML.

### Core System Stack
- **Language:** GNU Bash 4.x+
- **Underlying Scanning Engine:** Nmap (Network Mapper) 7.x+
- **Execution Script:** `scan.sh` (POSIX-compliant Bash executable)
- **Sample Automation:** `example_usage.sh`
- **Output Formats:** Human-readable `.txt` log and structured `.xml` artifact

---

## 2. Operational Invariants & Security Guardrails

The following invariants must be maintained across all modifications:
1. **Zero External Language Dependencies:** The tool must remain executable strictly using GNU Bash and Nmap; no Python, Node.js, or Ruby dependencies may be introduced into `scan.sh`.
2. **Variable Quoting Rule:** Every variable expansion must be double-quoted to prevent globbing and argument injection.
3. **Non-Destructive Logging:** Scans must never overwrite existing log files; unique timestamps must differentiate audit artifacts.
4. **Clean Interrupt Handling:** User interrupts (`SIGINT` / Ctrl+C) must trap cleanly and flush incomplete file writes to prevent orphaned, locked file descriptors.
5. **Clear Permission Feedback:** When elevated features (SYN scan, OS fingerprinting) are selected, the tool must explicitly inform the operator if root privileges are required.

---

## 3. High-Level Checklist & Completed Milestones

- [x] Command-line flag parsing supporting both short and long argument variants.
- [x] Terminal ASCII banner and contextual help documentation (`-h`/`--help`).
- [x] Quick scan mode (`-F -T4`) for high-speed alive-host triage.
- [x] Normal scan mode with ICMP ping sweep and service banner interrogation.
- [x] Full scan mode covering all 65,535 TCP ports with OS detection and default NSE scripts.
- [x] Simultaneous terminal streaming and persistent file logging via `tee`.
- [x] Structured XML output support (`-o xml`) for automated SIEM pipelines.
- [x] ShellCheck linter validation with zero syntax errors.
- [x] Example execution script and setup instructions (`RUNNING_INSTRUCTIONS.txt`).
- [x] Full 6-file documentation suite and responsive SVG design assets deployed.

---

## 4. Key References & Repository Layout

- **Main Script:** `scan.sh`: Primary reconnaissance orchestration CLI.
- **Example Runner:** `example_usage.sh`: Sample execution scenarios.
- **Setup Guide:** `RUNNING_INSTRUCTIONS.txt`: Detailed prerequisites and platform instructions.
- **Documentation Suite:** `docs/` (`PRD.md`, `ARCHITECTURE.md`, `RULES.md`, `DESIGN.md`, `TASKS.md`, `MEMORY.md`, `architecture.svg`, `palette.svg`, `principles.svg`).
