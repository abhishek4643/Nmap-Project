# System Architecture
### Automated Network Reconnaissance Tool — Topology, Script Dispatch Pipeline, and Technical Specifications

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=12,20,26&height=8&section=header&width=100%" width="100%" />
</div>

This document describes the architectural flow, component relationships, execution pipelines, and design decisions governing the **Automated Network Reconnaissance Tool**.

---

### 1. High-Level Architecture

The tool employs a decoupled execution pipeline separating command-line argument validation, pre-flight environment checks, Nmap socket orchestration, and structured file persistence:

<p align="center" style="margin: 20px 0;">
  <img src="./architecture.svg" alt="Automated Network Reconnaissance Architecture Flow" width="100%" />
</p>

---

### 2. Technology Stack & Scan Matrix

Technologies and scan configurations used across the reconnaissance suite:

| Component | Tool / Standard | Version | Implementation Detail |
|---|---|---|---|
| **Scripting Language** | GNU Bash | 4.0+ | POSIX-compliant modular shell script with signal trap handling |
| **Scanning Engine** | Nmap (Network Mapper) | 7.x+ | Raw socket SYN probes, OS fingerprinting, and NSE execution |
| **Output Pipeline** | GNU Coreutils (`tee`) | Standard | Dual-stream non-blocking stdout display and disk file appending |
| **Quick Scan Mode** | `-F -T4` | Top 100 | High-speed host discovery and responsive service verification |
| **Normal Scan Mode** | `-sn`, `-sV` | Top 1,000 | ICMP ping sweep, TCP SYN probe, and service banner grabbing |
| **Full Scan Mode** | `-p- -sV -O -sC` | 65,535 | Exhaustive port audit with OS fingerprinting and default scripts |

---

### 3. Folder Structure

The project follows a clean, modular structure separating execution scripts, automation runners, and documentation:

```text
Nmap-Project/
|-- docs/                               # Complete Engineering Documentation Suite
|   |-- ARCHITECTURE.md                 # System Topology & Algorithm Specifications
|   |-- DESIGN.md                       # Design System & CLI Specifications
|   |-- MEMORY.md                       # Operational State & Milestone Log
|   |-- PRD.md                          # Product Requirements & User Scenarios
|   |-- RULES.md                        # Engineering Conventions & Scripting Rules
|   |-- TASKS.md                        # Phased Roadmap with 20 Deliverables
|   |-- architecture.svg                # Custom 4-Card Vector Topology
|   |-- palette.svg                     # 8-Swatch Design System Vector Palette
|   `-- principles.svg                  # 4-Card Design Principles Vector
|-- example_usage.sh                    # Automated Example Execution Scenarios
|-- LICENSE                             # MIT Open-Source License
|-- README.md                           # Master Repository Overview
|-- RUNNING_INSTRUCTIONS.txt            # Environment & Command Setup Guide
`-- scan.sh                             # Primary Automated Reconnaissance CLI
```

---

### 4. Reconnaissance & Dispatch Pipeline

```text
[ User Input: CLI Target & Flags (-t, -m, -o) ]
                         |
                         v
[ Pre-Flight Validation: Nmap Binary Check & Target Format Verify ]
                         |
                         v
[ Mode Evaluator: Selects Execution Profile (quick / normal / full) ]
                         |
        +----------------+----------------+
        |                |                |
        v                v                v
[ Quick Scan ]    [ Normal Scan ]    [ Full Scan ]
(Top 100 Ports)   (Top 1,000 Ports)  (65,535 Ports)
(-F -T4)          (-sn, -sV)         (-p- -sV -O -sC)
        |                |                |
        +----------------+----------------+
                         |
                         v
[ Dual-Stream Redirection via GNU tee -a ]
                         |
        +----------------+----------------+
        |                                 |
        v                                 v
[ Real-Time Monospace Terminal ] [ Timestamped Audit Artifact ]
(ANSI Color Indicators)          (.txt Plaintext / .xml Schema)
```

---

### 5. Key Architectural Decisions (ADRs)

* **ADR-001: Native GNU Bash Implementation**  
  *Rationale*: Reconnaissance utilities are frequently executed on ephemeral jump hosts, remote bastions, and air-gapped systems where external runtimes (Python, Node.js) may not be installed. Building purely in POSIX-compliant GNU Bash guarantees zero runtime installation overhead.
* **ADR-002: Simultaneous Dual-Stream Output via tee**  
  *Rationale*: Security engineers need real-time stdout visibility during long-running audits, while compliance workflows require complete logs. Streaming output through `tee -a` guarantees simultaneous interactive feedback and permanent disk archival without buffering delays.
* **ADR-003: Modular Function Encapsulation**  
  *Rationale*: Hardcoding complex monolithic scan loops causes maintenance friction. Encapsulating discrete scan profiles into standalone Bash functions (`run_quick_scan`, `run_normal_scan`, `run_full_scan`) ensures modularity and testability.
