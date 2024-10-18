#!/bin/bash

# Log the start of execution
echo "Mint started at $(date)"

# Function to display script usage
show_help() {
    echo "Usage: $0 <address>"
    echo "Description: This script runs Bitcoin CLI commands with a 1-second interval between each execution."
    echo "Options:"
    echo "  <address>  Bitcoin address to use in the commands."
    echo "  --help     Display this help message."
}

# Check if the help option is provided
if [ "$1" == "--help" ]; then
    show_help
    exit 0
fi

# Check if an argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Missing <address> argument."
    show_help
    exit 1
fi

# Store the provided argument as the address
address="$1"

# Function to run the command with a 1-second interval
mint_command() {
    # Command to execute
    command=".bitcoin/bin/bitcoin-cli -conf=$(pwd)/bitcoin.conf generatetoaddress $1 $address"

    # Execute the command
    $command

    # Check the exit status of the command
    if [ $? -ne 0 ]; then
        echo "Error: Command failed. Exiting script."
        exit 1
    fi

    # Wait for 1 second
    sleep 1
}

# Run the first command with 50 blocks and the provided address
mint_command 50

# Run the second command with 50 blocks and the same address
mint_command 50

# Run the third command with 1 block and the same address
mint_command 1

sleep 4

# Log the end of execution
echo "Mint finished at $(date)"
