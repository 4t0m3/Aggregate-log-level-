#!/bin/bash

# Display a welcome message
cat <<EOF

Welcome to my Bash File log analyzer

Credits: 4t0m
＼(^o^)／

EOF

# Function to display usage instructions
function usage() {
    cat <<EOF
Usage: $0 [Argument] <logfile>
Arguments:
    aggregate           - Analyze log file 
    temporal_analysis   - Analyze log activity
EOF
}

# Display help page if no arguments are provided
if [ $# -eq 0 ]; then
    echo "ʕ•ᴥ•ʔ"
    echo -e "\e[31mError: No argument provided after the file.\e[0m \n"
    usage

    exit 1
fi

# Check if the log file is specified as an argument
if [ $# -lt 2 ]; then
  echo "Error: log file not specified"
  usage
  exit 1
fi

#Variables to store command and logfile
command=$1
logfile=$2

# Function to aggregate logs and analyze log levels and messages
aggregate_logs() {
  local filename=$1

  # Count occurrences of each log level
  trace_count=$(grep -c "\[trace\]" "$filename")
  debug_count=$(grep -c "\[debug\]" "$filename")
  info_count=$(grep -c "\[info\]" "$filename")
  warn_count=$(grep -c "\[warn\]" "$filename")
  error_count=$(grep -c "\[error\]" "$filename")
  fatal_count=$(grep -c "\[fatal\]" "$filename")

  # Identify the most and least common log messages
  most_common_msg=$(grep -oP 'msg=".*?"' "$filename" | sed 's/msg="//; s/"$//' | sort | uniq -c | sort -nr | head -n1 | awk '{$1=""; print $0}' | xargs)
  most_common_msg_count=$(grep -F "msg=\"$most_common_msg\"" "$filename" | wc -l)

  least_common_msg=$(grep -oP 'msg=".*?"' "$filename" | sed 's/msg="//; s/"$//' | sort | uniq -c | sort -n | head -n1 | awk '{$1=""; print $0}' | xargs)
  least_common_msg_count=$(grep -F "msg=\"$least_common_msg\"" "$filename" | wc -l)

  # Display results for aggregate analysis
  echo "=-= Aggregating file $filename =-="
  echo ""
  echo "Log level counts:"
  echo " - trace: $trace_count"
  echo " - debug: $debug_count"
  echo " - info: $info_count"
  echo " - warn: $warn_count"
  echo " - error: $error_count"
  echo " - fatal: $fatal_count"
  echo ""
  echo "Most common message: \"$most_common_msg\" (count: $most_common_msg_count)"
  echo "Least common message: \"$least_common_msg\" (count: $least_common_msg_count)"
  echo ""
  echo "=-= End of report =-="
  echo "¯\_(ツ)_/¯"
}
  
# Function to perform temporal analysis of log file
temporal_analysis() {
  filename=$1

  # Find the most active day and hour
  active_day_of_weeky=$(grep -oP '\d{4}-\d{2}-\d{2}' "$filename"   | sort | uniq -c | sort -nr | head -n 1  | xargs)
  most_active_day=$(date -d "$active_day_of_week" '+%A')

  most_active_hour=$(grep -oP '\d{2}:\d{2}:\d{2}' "$filename" |  cut -d ':' -f 1 | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

  # Find the hour with the most errors 
  most_errors_hour=$( grep -oP '\[(fatal|error)\].*' $filename | grep -oP '\d{2}:\d{2}:\d{2}' |  cut -d ':' -f 1 | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}' )
  
  # Diplay results for temporal analysis
  echo "=-= $filename temporal analysis $timeframe =-="
  echo ""
  echo "Most active day: $most_active_day"
  echo "Most active hour: $most_active_hour"
  echo "Most error-prone hour: $most_errors_hour"
  echo ""
  echo "=-= End of report =-="

}

# Execute the given command
case "$command" in
  aggregate)
    aggregate_logs "$logfile"
    ;;
  temporal_analysis)
    temporal_analysis "$logfile"
    ;;
  *)
   echo -e "\e[31mError: Unknown command '$command'.\e[0m"
   exit 1
    ;;
esac
