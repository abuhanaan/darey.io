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

## Real Life Scenario

```bash
#!/bin/bash
# Function to create S3 buckets for different departments
create_s3_buckets() {"\n    company=\"datawise\"\n    departments=(\"Marketing\" \"Sales\" \"HR\" \"Operations\" \"Media\")\n   
  for department in \"${departments[@]"}"; do
    bucket_name="${company}-${department}-Data-Bucket"
    
    # Check if the bucket already exists
    if aws s3api head-bucket --bucket "$bucket_name" &>/dev/null; then
        echo "S3 bucket '$bucket_name' already exists."
    else
        # Create S3 bucket using AWS CLI
        aws s3api create-bucket --bucket "$bucket_name" --region your-region
        if [ $? -eq 0 ]; then
            echo "S3 bucket '$bucket_name' created successfully."
        else
            echo "Failed to create S3 bucket '$bucket_name'."
        fi
    fi
  done
}
```

In the above snippet, the script is targetted at creating different s3 buckets for different departments in an organisation.
The outer if else block inside the for loop checks if s3 bucket for the current department already exists, if it does the control prints a descriptive message saying the department already has a bucket and the flow terminates, otherwise the control goes into the inner if else block.
In the inner if/else block, the script tries to create the s3 bucket for the current department in the loop leveraging on aws cli then checks if the creation attempt was succesful.
If the creation was successful, the control prints asuccess message and terminates otherwise, it prints a general error message saying the attempt to create the s3 bucket failed.

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
