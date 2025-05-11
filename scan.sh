#!/bin/bash

# Function to display banner
display_banner() {
    clear
    echo "============================================================="
    echo "           AUTOMATED NETWORK RECONNAISSANCE TOOL             "
    echo "                Using Nmap and Bash Scripting                "
    echo "============================================================="
    echo ""
}

# Function to display help
display_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -t, --target TARGET     Specify target IP or domain"
    echo "  -m, --mode MODE         Specify scan mode (quick, normal, full)"
    echo "  -o, --output FORMAT     Specify output format (txt, xml)"
    echo "  -h, --help              Display this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -t 192.168.1.1 -m quick"
    echo "  $0 -t example.com -m full -o xml"
    echo ""
    exit 0
}

# Function to run a quick scan
run_quick_scan() {
    echo -e "\nRunning Quick Scan..." | tee -a $filename
    echo "=====================================" | tee -a $filename
    nmap -F -T4 $target | tee -a $filename
}

# Function to run a normal scan
run_normal_scan() {
    # Ping Scan
    echo -e "\nRunning Ping Scan..." | tee -a $filename
    nmap -sn $target | tee -a $filename

    # Regular Port Scan
    echo -e "\n=====================================" | tee -a $filename
    echo -e "Running Port Scan (Top 1000 ports)..." | tee -a $filename
    echo -e "=====================================" | tee -a $filename
    nmap $target | tee -a $filename

    # Service and Version Detection
    echo -e "\n=====================================" | tee -a $filename
    echo -e "Running Service Version Detection..." | tee -a $filename
    echo -e "=====================================" | tee -a $filename
    nmap -sV $target | tee -a $filename
}

# Function to run a full comprehensive scan
run_full_scan() {
    # Ping Scan
    echo -e "\nRunning Ping Scan..." | tee -a $filename
    nmap -sn $target | tee -a $filename

    # Full Port Scan
    echo -e "\n=====================================" | tee -a $filename
    echo -e "Running Full Port Scan (All 65535 ports)..." | tee -a $filename
    echo -e "=====================================" | tee -a $filename
    nmap -p- -T4 $target | tee -a $filename

    # OS Detection and Service Version Detection
    echo -e "\n=====================================" | tee -a $filename
    echo -e "Running OS Detection and Service Version Scan..." | tee -a $filename
    echo -e "=====================================" | tee -a $filename
    nmap -A $target | tee -a $filename

    # Vulnerability Scan
    echo -e "\n=====================================" | tee -a $filename
    echo -e "Running Vulnerability Scan..." | tee -a $filename
    echo -e "=====================================" | tee -a $filename
    nmap --script vuln $target | tee -a $filename
}

# Default values
target=""
scan_mode="normal"
output_format="txt"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--target)
            target="$2"
            shift 2
            ;;
        -m|--mode)
            scan_mode="$2"
            shift 2
            ;;
        -o|--output)
            output_format="$2"
            shift 2
            ;;
        -h|--help)
            display_help
            ;;
        *)
            echo "Unknown option: $1"
            display_help
            ;;
    esac
done

# Display banner
display_banner

# Get target if not provided via command line
if [ -z "$target" ]; then
    read -p "Enter the target IP or domain: " target
fi

# Create timestamp for the scan
timestamp=$(date +"%Y%m%d_%H%M%S")
mkdir -p results

# Set filename based on output format
if [ "$output_format" == "xml" ]; then
    filename="results/${target}_${timestamp}_scan.xml"
    output_option="-oX $filename"
else
    filename="results/${target}_${timestamp}_scan.txt"
    output_option=""
fi

echo "Scanning host: $target"
echo "Scan mode: $scan_mode"
echo "Results will be saved in $filename"
echo ""

# Header for the scan results (only for text output)
if [ "$output_format" == "txt" ]; then
    echo "=====================================" | tee -a $filename
    echo "Nmap Scan Results for $target" | tee -a $filename
    echo "Scan started at: $(date)" | tee -a $filename
    echo "Scan mode: $scan_mode" | tee -a $filename
    echo "=====================================" | tee -a $filename
fi

# Run appropriate scan based on mode
case $scan_mode in
    "quick")
        run_quick_scan
        ;;
    "normal")
        run_normal_scan
        ;;
    "full")
        run_full_scan
        ;;
    *)
        echo "Invalid scan mode: $scan_mode. Using normal mode."
        run_normal_scan
        ;;
esac

# Finalize the output (only for text output)
if [ "$output_format" == "txt" ]; then
    echo -e "\n=====================================" | tee -a $filename
    echo -e "Scan completed at: $(date)" | tee -a $filename
    echo -e "=====================================" | tee -a $filename
fi

echo -e "\nScan completed. Check the file: $filename" 