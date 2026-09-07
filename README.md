# Automated Network Reconnaissance Tool

An automated network reconnaissance and vulnerability auditing toolkit built with Bash and Nmap, designed to perform rapid host discovery, comprehensive port enumeration, and structured security reporting.

[![Language](https://img.shields.io/badge/Language-Bash_Script-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Engine](https://img.shields.io/badge/Security-Nmap-002B36?style=for-the-badge)](https://nmap.org/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux_|_Unix_|_macOS-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.kernel.org/)

---

## Project Overview

Conducting manual network reconnaissance across enterprise infrastructure is repetitive and prone to inconsistent documentation. The Automated Network Reconnaissance Tool standardizes scanning workflows into an efficient, scriptable Bash utility. By encapsulating Nmap's powerful scanning primitives behind configurable execution modes (`quick`, `normal`, `full`), security professionals can rapidly discover live systems, detect outdated services, and produce formatted audit reports.

**Vision:** Streamline security assessments and perimeter auditing through reliable, repeatable automation that adheres to security best practices.

---

## Key Features

- **Multi-Tier Scan Modes:**
  - `quick`: Fast SYN scan targeting top standard ports for rapid discovery.
  - `normal`: Standard TCP port scan with service banner grabbing and default NSE script execution.
  - `full`: Exhaustive 65,535 port audit with aggressive operating system fingerprinting and vulnerability detection scripts.
- **Structured Output Generation:** Generates clean plaintext reports and machine-parseable XML files suitable for SIEM or vulnerability pipeline ingestion.
- **Robust Command-Line Interface:** Standardized argument parsing supporting flags (`-t/--target`, `-m/--mode`, `-o/--output`, `-h/--help`).
- **Target Flexibility:** Supports scanning individual IPv4/IPv6 addresses, fully qualified domain names (FQDNs), and CIDR subnet notations.
- **Execution Safeguards:** Validates target reachability, verifies user permissions, and ensures necessary dependencies are installed before execution.

---

## Use Cases

### For Penetration Testers & Red Teams
- Quickly execute standardized host discovery and service enumeration during initial engagement phases.
- Automate report generation to maintain an auditable paper trail of reconnaissance actions.

### For System Administrators & Blue Teams
- Audit network perimeter surfaces regularly to catch rogue services or unintentionally exposed ports.
- Validate firewall filtering rules following infrastructure migrations or configuration updates.

---

## System Architecture

```
+---------------------------------------------------------------+
|               Command-Line Invocation (scan.sh)               |
|  Flags: -t <target>  -m <quick|normal|full>  -o <txt|xml>    |
+---------------------------------------------------------------+
                                |
                                v
+---------------------------------------------------------------+
|                  Execution & Parsing Engine                   |
|  - Parameter Validation        - Target Resolution            |
|  - Scan Profile Selection      - Dependency Verification      |
+---------------------------------------------------------------+
                                |
                                v
+---------------------------------------------------------------+
|                    Nmap Engine Orchestration                  |
|  - Quick: Fast TCP SYN Scan (-F -T4)                          |
|  - Normal: Service Detection (-sV -sC -T4)                   |
|  - Full: All Ports + Aggressive NSE Scripting (-p- -A)       |
+---------------------------------------------------------------+
                                |
                                v
+---------------------------------------------------------------+
|                       Report Artifacts                        |
|  - Structured Plaintext Report (.txt)                         |
|  - Machine-Parseable XML (.xml)                               |
+---------------------------------------------------------------+
```

---

## Technology Stack

| Layer | Technologies |
|---|---|
| Scripting Language | Bash (Bourne-Again SHell) >= 4.0 |
| Core Reconnaissance Engine | Nmap (Network Mapper) >= 7.80 |
| Utilities | POSIX Coreutils (grep, sed, awk, date, tee) |
| Output Formats | Plaintext (.txt), XML (.xml) |
| Target Platforms | Linux (Ubuntu, Debian, Kali, Arch), macOS |

---

## Project Structure

```
Nmap-Project/
├── scan.sh                     # Main automated reconnaissance script
├── example_usage.sh            # Demonstration scenarios and automated test runs
├── RUNNING_INSTRUCTIONS.txt    # Step-by-step setup and execution guide
├── LICENSE                     # MIT open-source license
└── README.md                   # Project documentation
```

---

## Getting Started

### Prerequisites
- POSIX-compliant operating system (Linux, macOS, or WSL2 on Windows)
- Bash 4.0 or higher
- Nmap installed and accessible via `PATH`

Install Nmap on Debian/Ubuntu/Kali:
```bash
sudo apt update && sudo apt install -y nmap
```

Install Nmap on macOS (via Homebrew):
```bash
brew install nmap
```

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/abhishek4643/Nmap-Project.git
   cd Nmap-Project
   ```

2. Grant execution permissions:
   ```bash
   chmod +x scan.sh example_usage.sh
   ```

### Usage Examples

Display help and available options:
```bash
./scan.sh -h
```

Execute a rapid scan against a target:
```bash
./scan.sh -t 192.168.1.1 -m quick
```

Perform a comprehensive scan with XML report output:
```bash
sudo ./scan.sh -t scanme.nmap.org -m full -o xml
```

Run the pre-configured demonstration scenarios:
```bash
./example_usage.sh
```

---

## Future Roadmap

- Automated HTML dashboard report generation using custom XSL stylesheets.
- Slack and Discord webhook integration to broadcast critical open port discoveries.
- Passive DNS and WHOIS reconnaissance module integration.
- Multi-threaded batch CIDR subnet scanning queue.

---

## Disclaimer

This tool is designed strictly for authorized educational and defensive security auditing purposes. Scanning targets without explicit prior authorization is illegal. The author assumes no liability for misuse.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
