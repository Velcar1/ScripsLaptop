#!/bin/bash

# Function to scan for Bluetooth devices
scan_devices() {
    echo "Scanning for Bluetooth devices..."
    bluetoothctl --timeout 10 scan on
}

# Function to list available devices
list_devices() {
    echo "Available devices:"
    bluetoothctl devices | nl
}

# Function to select a device
select_device() {
    local device_count=$(bluetoothctl devices | wc -l)
    
    if [ $device_count -eq 0 ]; then
        echo "No devices found. Please make sure Bluetooth is enabled and devices are in range."
        exit 1
    fi

    read -p "Enter the number of the device you want to select: " selection

    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "$device_count" ]; then
        echo "Invalid selection. Please enter a number between 1 and $device_count."
        exit 1
    fi

    local selected_device=$(bluetoothctl devices | sed -n "${selection}p" | cut -d ' ' -f 2)
    echo "You selected device with MAC address: $selected_device"
    
    echo "Attempting to connect..."
    bluetoothctl -- connect $selected_device
}

# Main script
scan_devices
list_devices
select_device
