# Win10_Unattend

## Unnattended OS setup for Windows 10 (Versions 1809+)

Intended to be used in conjunction with SCCM Task sequences for OSD deployments

Provides zero-touch setup of some key settings during the OOBE experience after Windows has finished setting up on a device

## 1. Internalization settings set to en-US

### 1a. Input Keyboard - US International
  
### 1b. Locale - en-US
  
###  1c. UI Language - en-US
  
###  1d. Fallback UI language - en-US
  
###  1e. User locale - en-US

## 2. OOBE Settings
### 2a. VM Mode Optimizations - enabled
####    2a1. Local Admin Profile removal Skip - enabled
####    2a2. UI Language change notification Skip - enabled
###  2b. Accept EULA by default - enabled
###  2c. Hide Local Account creation wizard - enabled
###  2d. Hide OEM Registration wizard - enabled
###  2e. Hide networks setup - enabled
###  2f. Express Advertisement / speech / ink / diagnostic data settings - DISABLED


## 3. Themes
###  3a. Dark mode enabled - for system apps (**no UWP**) - enabled
###  3b. Window color - **0xff1b1b1b**

