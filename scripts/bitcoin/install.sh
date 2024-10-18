#!/bin/bash

# Get Bitcoin download URL based on the operating system
get_bitcoin_download_url() {
  local os_type
  os_type="$(uname -s)"
  bitcoin_version=26.0

  if [ "$os_type" = "Linux" ]; then
    echo "https://bitcoincore.org/bin/bitcoin-core-$bitcoin_version/bitcoin-$bitcoin_version-x86_64-linux-gnu.tar.gz"
  elif [ "$os_type" = "Darwin" ]; then
    echo "https://bitcoincore.org/bin/bitcoin-core-$bitcoin_version/bitcoin-$bitcoin_version-arm64-apple-darwin.tar.gz"
  else
    echo "Unsupported operating system: $os_type"
    exit 1
  fi
}

# Download and extract bitcoin files
download_and_extract() {
  local url="$1"
  local destination="$2"
  
  curl -o bitcoin.tar.gz "$url" || { echo "Error downloading the file."; exit 1; }
  
  if [ ! -d "$destination" ]; then
    mkdir -p "$destination" || { echo "Error creating destination directory."; exit 1; }
  fi
  
  tar xzf bitcoin.tar.gz -k --strip-components=1 --directory="$destination" || { echo "Error extracting the file."; exit 1; }
  rm -rf bitcoin.tar.gz
}

# Creating directories
if [ ! -d ".bitcoin" ]; then
  mkdir .bitcoin
fi

if [ ! -d ".bitcoin/data" ]; then
  mkdir .bitcoin/data
fi

# Downloading and extracting bitcoind if it doesn't exist
if [ ! -f ".bitcoin/bin/bitcoind" ]; then
  echo "Downloading and extracting bitcoind..."
  # Using the function to get the download URL
  bitcoin_url=$(get_bitcoin_download_url)
  download_and_extract "$bitcoin_url" ".bitcoin/"
  echo "bitcoind has been downloaded and extracted successfully."
else
  echo "bitcoind is already installed."
fi
