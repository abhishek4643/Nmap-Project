# Automated Network Reconnaissance using Nmap and Bash

A beginner-friendly network scanning tool that automates common Nmap operations using Bash scripting.

## Overview

This tool helps cybersecurity enthusiasts and beginners understand how to:
- Perform basic network reconnaissance
- Automate scanning tasks with different levels of scanning intensity
- Generate organized reports in different formats
- Create modular Bash scripts with functions and command-line arguments

## Features

- Multiple scan modes (quick, normal, full)
- Command-line interface with options and help
- Output format selection (text or XML)
- Ping scan to identify live hosts
- Comprehensive port scanning
- OS detection and service version identification
- Vulnerability scanning
- Timestamped output files for easy reference

## Prerequisites

- Linux operating system
- Nmap installed (`sudo apt-get install nmap` on Debian/Ubuntu)
- Bash shell

## Installation

1. Clone this repository:
```
git clone https://github.com/yourusername/nmap-bash-scanner.git
cd nmap-bash-scanner
```

2. Make the script executable:
```
chmod +x scan.sh
```

## Usage

### Interactive Mode

Run the script without any arguments:
```
./scan.sh
```

### Command-line Mode

Run with specific options:
```
./scan.sh -t 192.168.1.1 -m quick
```

### Available Options

- `-t, --target TARGET`: Specify target IP or domain
- `-m, --mode MODE`: Specify scan mode (quick, normal, full)
- `-o, --output FORMAT`: Specify output format (txt, xml)
- `-h, --help`: Display help message

### Examples

```
./scan.sh -t 192.168.1.1 -m quick
./scan.sh -t example.com -m full -o xml
```

## Scan Modes

1. **Quick Scan**: Fast scan of the most common ports
   - Uses `-F -T4` flags for speed
   - Great for initial reconnaissance

2. **Normal Scan** (default): Balanced scan with moderate detail
   - Ping scan to check host availability
   - Regular port scan (top 1000 ports)
   - Service version detection

3. **Full Scan**: Comprehensive scan with maximum information
   - Ping scan to check host availability
   - Full port scan (all 65535 ports)
   - OS detection and service version detection
   - Vulnerability scanning with NSE scripts

## Output

All scan results are saved in the `results/` directory with the naming format:
```
results/[target]_[timestamp]_scan.txt
```
or
```
results/[target]_[timestamp]_scan.xml
```

## Caution

- Always obtain proper authorization before scanning any network or system
- Only use this tool on systems you own or have explicit permission to scan
- Scanning without permission is illegal in many jurisdictions

## Project Structure

```
nmap-bash-scanner/
├── README.md       # Documentation
├── scan.sh         # Main script
├── example_usage.sh # Usage examples
├── results/        # Scan output directory
│   └── [targetname]_[timestamp]_scan.txt
└── LICENSE         # License file
```

## Future Improvements

- HTML report generation
- Email alerting for critical findings
- Custom scan profiles
- Interactive menu for scan selection
- Integration with other security tools

## License

This project is licensed under the MIT License - see the LICENSE file for details. 