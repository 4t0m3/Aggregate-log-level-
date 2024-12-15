# Bash File Log Analyzer

## Description

This script is a Bash-based log file analyzer that provides functionality to:
- Aggregate log file data (e.g., log level counts and message frequency).
- Perform temporal analysis of log activity.

### Credits

Script author: 4t0m 
`＼(^o^)／`

---

## Features

1. **Aggregate Logs**:  
   Analyzes log levels (`trace`, `debug`, `info`, `warn`, `error`, `fatal`) and identifies the most and least common log messages.

2. **Temporal Analysis**:  
   Identifies the most active day, hour, and the hour with the highest error frequency.

---

## Usage

```bash
./script_name.sh [Argument] <logfile>
```

### Arguments:
- `aggregate` - Perform aggregation analysis of the log file.
- `temporal_analysis` - Analyze the temporal activity of logs.

### Examples:
1. **Aggregate Analysis**:
   ```bash
   ./script_name.sh aggregate example.log
   ```
   Output:
   ```
   =-= Aggregating file example.log =-=

   Log level counts:
    - trace: 10
    - debug: 5
    - info: 20
    - warn: 2
    - error: 1
    - fatal: 0

   Most common message: "User login" (count: 15)
   Least common message: "System rebooted" (count: 1)

   =-= End of report =-=
   ¯\_(ツ)_/¯
   ```

2. **Temporal Analysis**:
   ```bash
   ./script_name.sh temporal_analysis example.log
   ```
   Output:
   ```
   =-= example.log temporal analysis =-=

   Most active day: Monday
   Most active hour: 14
   Most error-prone hour: 22

   =-= End of report =-=
   ```

---

## Requirements

- Bash shell
- `grep`, `awk`, `sed`, `sort`, `bc`, `date`,`head`,`uniq`,`tail`,`cut`,`xargs`

---

## Error Handling

1. **No Arguments Provided**:
   If the script is executed without arguments:
   ```bash
   ./script_name.sh
   ```
   Output:
   ```
   ʕ•ᴥ•ʔ
   Error: No argument provided after the file.

   Usage: ./script_name.sh [Argument] <logfile>
   ```

2. **Missing Log File**:
   If a log file is not specified:
   ```bash
   ./script_name.sh aggregate
   ```
   Output:
   ```
   Error: log file not specified
   ```

3. **Unknown Command**:
   If an unsupported command is entered:
   ```bash
   ./script_name.sh unknown example.log
   ```
   Output:
   ```
   Error: Unknown command 'unknown'.
   ```

---

## Notes

This script includes a function to determine the day of the week based on a given date, inspired by [Waterloo's Math FAQ](https://cs.uwaterloo.ca/~alopez-o/math-faq/node73.html).

Happy analyzing!  
¯\_(ツ)_/¯
