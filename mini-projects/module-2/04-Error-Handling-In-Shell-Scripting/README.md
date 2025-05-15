# ⚠️ Error Handling in Shell Scripting (Bash)

Proper error handling is essential in shell scripts to detect failures and act accordingly, improving script reliability and debuggability.

---

## ✅ 1. **Exit Status Check (`$?`)**

Every command returns an **exit status**:

* `0` = success
* non-zero = error

```bash
mkdir /tmp/mydir
if [ $? -ne 0 ]; then
  echo "Failed to create directory"
fi
```

---

## ✅ 2. **Using `set` for Safer Scripts**

```bash
set -e     # Exit immediately if any command fails
set -u     # Treat unset variables as an error
set -o pipefail  # Fail pipeline if any command fails
```

💡 Recommended at the top of production scripts:

```bash
#!/bin/bash
set -euo pipefail
```

---

## ✅ 3. **Using `trap` to Catch Errors or Interrupts**

```bash
trap 'echo "An error occurred. Exiting..."; exit 1' ERR
trap 'echo "Script interrupted"; exit' INT
```

* `ERR` – triggers on any command failure
* `INT` – handles `Ctrl + C` (SIGINT)

---

## ✅ 4. **Custom Error Handling with Functions**

```bash
handle_error() {
  echo "Error on line $1"
  exit 1
}

trap 'handle_error $LINENO' ERR
```

---

## ✅ 5. **Conditionally Handling Command Failures**

```bash
cp file.txt /destination/ || {
  echo "Copy failed!"
  exit 1
}
```

---

## ✅ 6. **Using `exit` to Return Status**

Use `exit [code]` to manually terminate a script:

```bash
if [ ! -f "config.cfg" ]; then
  echo "Missing config file"
  exit 1
fi
```

---

### 🧠 Summary of Good Practices

| Technique | Purpose                              |    |                      |
| --------- | ------------------------------------ | -- | -------------------- |
| `set -e`  | Stop script on first error           |    |                      |
| `set -u`  | Error on undefined variables         |    |                      |
| `trap`    | Catch signals and errors gracefully  |    |                      |
| `$?`      | Check individual command exit status |    |                      |
| \`        |                                      | \` | Handle errors inline |
| `exit`    | Exit script with specific status     |    |                      |

---
