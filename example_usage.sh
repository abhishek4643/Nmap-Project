#!/bin/bash

# Examples of using the automated network reconnaissance tool

echo "==============================================="
echo "      EXAMPLES OF USING NMAP BASH SCANNER     "
echo "==============================================="
echo ""

echo "Example 1: Quick scan of local host"
echo "./scan.sh -t 127.0.0.1 -m quick"
echo ""

echo "Example 2: Normal scan of a specific IP address"
echo "./scan.sh -t 192.168.1.1"
echo ""

echo "Example 3: Full scan of a domain with XML output"
echo "./scan.sh -t example.com -m full -o xml"
echo ""

echo "Example 4: Running with interactive mode"
echo "./scan.sh"
echo ""

echo "Example 5: Display help information"
echo "./scan.sh -h"
echo ""

echo "Note: Always ensure you have proper authorization before scanning any network!"
echo "Use these examples only on systems you own or have permission to scan." 