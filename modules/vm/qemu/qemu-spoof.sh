if [[ -z $LOG_PATH || -z $LOG_FILE ]]; then

  readonly LOG_PATH="$(pwd)/logs"
  export LOG_PATH

  readonly LOG_FILE="${LOG_PATH}/$(date +%s).log"
  export LOG_FILE

  # makes sure the log file is created successfully
  if ! (mkdir -p "$LOG_PATH" && touch "$LOG_FILE"); then
    exit 1
  fi

fi

function dbg::fail() {
  fmtr::fatal "$1"
  exit 1
}

#
# A library to format text in the terminal.
# The ANSI text color and style codes are all provided as environment variables
# and can be easily used in the standardized function "format_text".
# For messages to the user use the
# ask, log, info, warn, error and fatal wrapper functions.
# And for important information and titles, you may use box_text
#

# exports ANSI codes as read-only variables
declare -xr RESET="\033[0m"
# text styles
declare -xr BOLD="\033[1m"
declare -xr DIM="\033[2m"
declare -xr ITALIC="\033[3m"
declare -xr UNDER="\033[4m"
declare -xr BLINK="\033[5m"
declare -xr REVERSE="\033[7m"
declare -xr HIDDEN="\033[8m"
declare -xr STRIKE="\033[9m"
# text colors
declare -xr TEXT_BLACK="\033[30m"
declare -xr TEXT_GRAY="\033[90m"
declare -xr TEXT_RED="\033[31m"
declare -xr TEXT_BRIGHT_RED="\033[91m"
declare -xr TEXT_GREEN="\033[32m"
declare -xr TEXT_BRIGHT_GREEN="\033[92m"
declare -xr TEXT_YELLOW="\033[33m"
declare -xr TEXT_BRIGHT_YELLOW="\033[93m"
declare -xr TEXT_BLUE="\033[34m"
declare -xr TEXT_BRIGHT_BLUE="\033[94m"
declare -xr TEXT_MAGENTA="\033[35m"
declare -xr TEXT_BRIGHT_MAGENTA="\033[95m"
declare -xr TEXT_CYAN="\033[36m"
declare -xr TEXT_BRIGHT_CYAN="\033[96m"
declare -xr TEXT_WHITE="\033[37m"
declare -xr TEXT_BRIGHT_WHITE="\033[97m"
# background colors
declare -xr BACK_BLACK="\033[40m"
declare -xr BACK_GRAY="\033[100m"
declare -xr BACK_RED="\033[41m"
declare -xr BACK_BRIGHT_RED="\033[101m"
declare -xr BACK_GREEN="\033[42m"
declare -xr BACK_BRIGHT_GREEN="\033[102m"
declare -xr BACK_YELLOW="\033[43m"
declare -xr BACK_BRIGHT_YELLOW="\033[103m"
declare -xr BACK_BLUE="\033[44m"
declare -xr BACK_BRIGHT_BLUE="\033[104m"
declare -xr BACK_MAGENTA="\033[45m"
declare -xr BACK_BRIGHT_MAGENTA="\033[105m"
declare -xr BACK_CYAN="\033[46m"
declare -xr BACK_BRIGHT_CYAN="\033[106m"
declare -xr BACK_WHITE="\033[47m"
declare -xr BACK_BRIGHT_WHITE="\033[107m"

###############################################################
# Formats a part of the provided string using ANSI escape codes
# Globals:
#   RESET: The escape code that resets formatting
# Arguments:
#   $1: Unformatted text before $2
#   $2: The text to be formatted
#   $3: Unformatted text after $2
#   ${*:4}: ANSI codes to set on $2
# Outputs:
#   Writes complete string with ANSI codes to STDOUT
###############################################################
function fmtr::format_text() {
  local prefix="$1"
  local text="$2"
  local suffix="$3"
  local codes="${*:4}"
  echo -e "${prefix}${codes// /}${text}${RESET}${suffix}"
}

#######################################################
# Provides stylized decorations for prompts to the user
# Globals:
#   TEXT_BLACK
#   BACK_BRIGHT_GREEN
# Arguments:
#   Question to ask to the user
# Outputs:
#   Formatted question for the user to STDOUT
#######################################################
function fmtr::ask() {
  local text="$1"
  local message="$(fmtr::format_text \
    '\n  ' "[?]" " ${text}" "$TEXT_BLACK" "$BACK_BRIGHT_GREEN")"
  echo "$message" | tee -a "$LOG_FILE"
}

################################################
# Provides stylized decorations for log messages
# Globals:
#   TEXT_BRIGHT_GREEN
# Arguments:
#   Message to log
# Outputs:
#   Formatted log message to STDOUT
################################################
function fmtr::log() {
  local text="$1"
  local message="$(fmtr::format_text \
    '\n  ' "[+]" " ${text}" "$TEXT_BRIGHT_GREEN")"
  echo "$message" | tee -a "$LOG_FILE"
}

########################################################
# Provides stylized decorations for messages to the user
# Globals:
#   TEXT_BRIGHT_CYAN
# Arguments:
#   The message to the user
# Outputs:
#   Formatted info message
########################################################
function fmtr::info() {
  local text="$1"
  local message="$(fmtr::format_text \
    '\n  ' "[i]" " ${text}" "$TEXT_BRIGHT_CYAN")"
  echo "$message" | tee -a "$LOG_FILE"
}

########################################################
# Provides stylized decorations for warnings to the user
# Globals:
#   TEXT_BRIGHT_YELLOW
# Arguments:
#   The important message to the user
# Outputs:
#   Formatted warning
########################################################
function fmtr::warn() {
  local text="$1"
  local message="$(fmtr::format_text \
    '\n  ' "[!]" " ${text}" "$TEXT_BRIGHT_YELLOW")"
  echo "$message" | tee -a "$LOG_FILE"
}

##############################################################
# Provides stylized decorations for recoverable error messages
# Globals:
#   TEXT_BRIGHT_RED
# Arguments:
#   The error to print
# Outputs:
#   Formatted error message
########################################################
function fmtr::error() {
  local text="$1"
  local message="$(fmtr::format_text \
    '\n  ' "[-]" " ${text}" "$TEXT_BRIGHT_RED")"
  echo "$message" >&2
  echo "$message" &>>"$LOG_FILE"
}

##############################################################
# Provides stylized decorations for fatal/unrecoverable errors
# Globals:
#   TEXT_BRIGHT_CYAN
#   BOLD
# Arguments:
#   The fatal error message
# Outputs:
#   Formatted error message
##############################################################
function fmtr::fatal() {
  local text="$1"
  local message="$(fmtr::format_text \
    '\n  ' "[X] ${text}" '' "$TEXT_RED" "$BOLD")"
  echo "$message" >&2
  echo "$message" &>>"$LOG_FILE"
}

#################################################
# Draws a beautiful box around a provided string
# Arguments:
#   String to format
# Outputs:
#   Writes text box to STDOUT in multiple strings
#################################################
function fmtr::box_text() {
  local text="$1"
  local width=$((${#text} + 2))

  # top decoration
  printf "\n  ╔"
  printf "═%.0s" $(seq 1 $width)
  printf "╗\n"

  # pastes text into middle
  printf "  ║ %s ║\n" "$text"

  # bottom decoration
  printf "  ╚"
  printf "═%.0s" $(seq 1 $width)
  printf "╝\n"
}

spoof_serial_numbers() {
  get_random_serial() { head /dev/urandom | tr -dc 'A-Z0-9' | head -c "$1"; }

  local patterns=("STRING_SERIALNUMBER" "STR_SERIALNUMBER" "STR_SERIAL_MOUSE" "STR_SERIAL_TABLET" "STR_SERIAL_KEYBOARD" "STR_SERIAL_COMPAT")
  local regex_pattern="($(
    IFS=\|
    echo "${patterns[*]}"
  ))"

  find "$(pwd)/hw/usb" -type f -exec grep -lE "\[$regex_pattern\]" {} + | while read -r file; do
    tmpfile=$(mktemp)

    while IFS= read -r line; do
      if [[ $line =~ \[$regex_pattern\] ]]; then
        local new_serial="$(get_random_serial 10)"
        line=$(echo "$line" | sed -E "s/(\[$regex_pattern\] *= *\")[^\"]*/\1${new_serial}/")
      fi
      echo "$line" >>"$tmpfile"
    done <"$file"

    mv "$tmpfile" "$file"
  done
}

spoof_drive_serial_number() {
  local core_file="hw/ide/core.c"

  local ide_cd_models=(
    "HL-DT-ST BD-RE WH16NS60" "HL-DT-ST DVDRAM GH24NSC0"
    "HL-DT-ST BD-RE BH16NS40" "HL-DT-ST DVD+-RW GT80N"
    "HL-DT-ST DVD-RAM GH22NS30" "HL-DT-ST DVD+RW GCA-4040N"
    "Pioneer BDR-XD07B" "Pioneer DVR-221LBK" "Pioneer BDR-209DBK"
    "Pioneer DVR-S21WBK" "Pioneer BDR-XD05B" "ASUS BW-16D1HT"
    "ASUS DRW-24B1ST" "ASUS SDRW-08D2S-U" "ASUS BC-12D2HT"
    "ASUS SBW-06D2X-U" "Samsung SH-224FB" "Samsung SE-506BB"
    "Samsung SH-B123L" "Samsung SE-208GB" "Samsung SN-208DB"
    "Sony NEC Optiarc AD-5280S" "Sony DRU-870S" "Sony BWU-500S"
    "Sony NEC Optiarc AD-7261S" "Sony AD-7200S" "Lite-On iHAS124-14"
    "Lite-On iHBS112-04" "Lite-On eTAU108" "Lite-On iHAS324-17"
    "Lite-On eBAU108" "HP DVD1260i" "HP DVD640"
    "HP BD-RE BH30L" "HP DVD Writer 300n" "HP DVD Writer 1265i"
  )

  local ide_cfata_models=(
    "SanDisk Ultra microSDXC UHS-I" "SanDisk Extreme microSDXC UHS-I"
    "SanDisk High Endurance microSDXC" "SanDisk Industrial microSD"
    "SanDisk Mobile Ultra microSDHC" "Samsung EVO Select microSDXC"
    "Samsung PRO Endurance microSDHC" "Samsung PRO Plus microSDXC"
    "Samsung EVO Plus microSDXC" "Samsung PRO Ultimate microSDHC"
    "Kingston Canvas React Plus microSD" "Kingston Canvas Go! Plus microSD"
    "Kingston Canvas Select Plus microSD" "Kingston Industrial microSD"
    "Kingston Endurance microSD" "Lexar Professional 1066x microSDXC"
    "Lexar High-Performance 633x microSDHC" "Lexar PLAY microSDXC"
    "Lexar Endurance microSD" "Lexar Professional 1000x microSDHC"
    "PNY Elite-X microSD" "PNY PRO Elite microSD"
    "PNY High Performance microSD" "PNY Turbo Performance microSD"
    "PNY Premier-X microSD" "Transcend High Endurance microSDXC"
    "Transcend Ultimate microSDXC" "Transcend Industrial Temp microSD"
    "Transcend Premium microSDHC" "Transcend Superior microSD"
    "ADATA Premier Pro microSDXC" "ADATA XPG microSDXC"
    "ADATA High Endurance microSDXC" "ADATA Premier microSDHC"
    "ADATA Industrial microSD" "Toshiba Exceria Pro microSDXC"
    "Toshiba Exceria microSDHC" "Toshiba M203 microSD"
    "Toshiba N203 microSD" "Toshiba High Endurance microSD"
  )

  local default_models=(
    "Samsung SSD 970 EVO 1TB" "Samsung SSD 860 QVO 1TB"
    "Samsung SSD 850 PRO 1TB" "Samsung SSD T7 Touch 1TB"
    "Samsung SSD 840 EVO 1TB" "WD Blue SN570 NVMe SSD 1TB"
    "WD Black SN850 NVMe SSD 1TB" "WD Green 1TB SSD"
    "WD Blue 3D NAND 1TB SSD" "Crucial P3 1TB PCIe 3.0 3D NAND NVMe SSD"
    "Seagate BarraCuda SSD 1TB" "Seagate FireCuda 520 SSD 1TB"
    "Seagate IronWolf 110 SSD 1TB" "SanDisk Ultra 3D NAND SSD 1TB"
    "Seagate Fast SSD 1TB" "Crucial MX500 1TB 3D NAND SSD"
    "Crucial P5 Plus NVMe SSD 1TB" "Crucial BX500 1TB 3D NAND SSD"
    "Crucial P3 1TB PCIe 3.0 3D NAND NVMe SSD"
    "Kingston A2000 NVMe SSD 1TB" "Kingston KC2500 NVMe SSD 1TB"
    "Kingston A400 SSD 1TB" "Kingston HyperX Savage SSD 1TB"
    "SanDisk SSD PLUS 1TB" "SanDisk Ultra 3D 1TB NAND SSD"
  )

  get_random_element() {
    local array=("$@")
    echo "${array[RANDOM % ${#array[@]}]}"
  }

  local new_ide_cd_model=$(get_random_element "${ide_cd_models[@]}")
  local new_ide_cfata_model=$(get_random_element "${ide_cfata_models[@]}")
  local new_default_model=$(get_random_element "${default_models[@]}")

  sed -i "$core_file" -Ee "s/\"HL-DT-ST BD-RE WH16NS60\"/\"${new_ide_cd_model}\"/"
  sed -i "$core_file" -Ee "s/\"Hitachi HMS360404D5CF00\"/\"${new_ide_cfata_model}\"/"
  sed -i "$core_file" -Ee "s/\"Samsung SSD 980 500GB\"/\"${new_default_model}\"/"
}

spoof_acpi_table_data() {

  ##################################################
  ##################################################

  # Spoofs 'OEM ID' and 'OEM Table ID' for ACPI tables.

  local oem_pairs=(
    'DELL  ' 'Dell Inc' ' ASUS ' 'Notebook'
    'MSI NB' 'MEGABOOK' 'LENOVO' 'TC-O5Z  '
    'LENOVO' 'CB-01   ' 'SECCSD' 'LH43STAR'
    'LGE   ' 'ICL     '
  )

  if [[ $CPU_VENDOR == "amd" ]]; then
    oem_pairs+=('ALASKA' 'A M I ')
  elif [[ $CPU_VENDOR == "intel" ]]; then
    oem_pairs+=('INTEL ' 'U Rvp   ')
  fi

  local total_pairs=$((${#oem_pairs[@]} / 2))
  local random_index=$((RANDOM % total_pairs * 2))
  local appname6=${oem_pairs[$random_index]}
  local appname8=${oem_pairs[random_index + 1]}
  local h_file="include/hw/acpi/aml-build.h"

  sed -i "$h_file" -e "s/^#define ACPI_BUILD_APPNAME6 \".*\"/#define ACPI_BUILD_APPNAME6 \"${appname6}\"/"
  sed -i "$h_file" -e "s/^#define ACPI_BUILD_APPNAME8 \".*\"/#define ACPI_BUILD_APPNAME8 \"${appname8}\"/"

  ##################################################
  ##################################################

  # Default QEMU has an unspecified PM type in the FACP ACPI table.
  # On baremetal normally vendors specify either 1 (Desktop) or 2 (Notebook).
  # We patch the PM type integer based on the chassis type output from dmidecode.

  fmtr::info "Obtaining machine's chassis-type..."

  local c_file="hw/acpi/aml-build.c"
  local pm_type="1" # Desktop

  if [[ $chassis_type == "Notebook" ]]; then
    pm_type="2" # Notebook/Laptop/Mobile
  fi

  sed -i 's/build_append_int_noprefix(tbl, 0 \/\* Unspecified \*\//build_append_int_noprefix(tbl, '"$pm_type"' \/\* '"$chassis_type"' \*\//g' "$c_file"

  ##################################################
  ##################################################

}

main() {
  echo "1"
  spoof_serial_numbers
  echo "2"
  spoof_drive_serial_number
  echo "3"
  spoof_acpi_table_data
}

main
