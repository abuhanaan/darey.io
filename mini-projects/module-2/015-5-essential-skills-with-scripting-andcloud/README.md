# 5 Essentials Skills To Elevate One's Scripting Journey To Cloud Computing

- Functions
- Arrays
- Environmenta Variables
- Command Line Arguments
- Error Handling

## Delivering Shell Scripting Based On A Real World Scenario

### Problem Statement

**DataWise Solutions** is a forward thinking Data Science Consulting Company that specializes in deploying analytical and machine learning environments to support data driven decision-making for its client. Recognizing the need for agility and efficiency in setting up such environments, DataWise has decided to streamline its deployment process on AWS focusing on simplicity and automation.

#### Scenario

One of DataWise Solution's client, a burgeonin ge-commerce startup, is looking to harness the power of data science to analyze customer behaviour and enhance their shopping experience. The startup wishes to deploy their data science workspace on AWS, utilizing EC2 instances for computational tasks and s3 buckets for storing their vast datasets of customer interactions.

#### Specific Requirements

To meet the client needs and ensure a practical learning experiance, DataWise solutions plan to develop a script that automates the setup of EC2 instances and s3 buckets. This script will incorporate the 5 critical shell scripting concepts previously identified:

- **Functions:** Implement custom functions to modularize tasks like creating EC2 instances, configuring s3 buckets, and verifying deployment statuses.
- **Arrays:** Use arrays to manage a list of resources created, ensuring easy tracking and manipulation.
- **Environment Variables:** Leverage environment variables to store sensitive information like AWS credentials, region settings, and configuration parameters, enhancing script portability and security.
- **Command Line Arguments:** Accept command line arguments to customize the script's behaviour, such as specifying th EC2 instance type or s3 bucket name, enabling dynamic and flexible deployments
- **Error Handling:** Implement robust error handling mechanisms to catch and respond to AWS service exceptions, ensuring the script can recover gracefully from failures.

### Requirements Breakdown/Understanding for the DataWise Solutions AWS Automation Script

#### 1. Functions

- **What:** Break the script into reusable sections (functions) for each major task.
- **Why:** This makes the script organized, easier to read, and maintain.
- **How:** Write separate functions for:
  - Creating EC2 instances
  - Creating/configuring S3 buckets
  - Checking if resources were created successfully

---

#### 2. Arrays

- **What:** Use arrays to store lists of resources (like EC2 instance IDs or S3 bucket names).
- **Why:** Arrays help to keep track of multiple resources, making it easy to loop through them for status checks or clean-up.
- **How:** For example, after creating EC2 instances, add their IDs to an array for later reference.

---

#### 3. Environment Variables

- **What:** Store sensitive or configurable information (like AWS credentials, region, or instance type) in environment variables.
- **Why:** This keeps the script secure (no hardcoding secrets) and portable (easy to change settings without editing the script).
- **How:** Use variables like `$AWS_ACCESS_KEY_ID`, `$AWS_SECRET_ACCESS_KEY`, `$AWS_DEFAULT_REGION`, etc. One can export these before running the script or read them from a `.env` file.

---

#### 4. Command Line Arguments

- **What:** Allow users to pass options (like instance type or bucket name) when running the script.
- **Why:** This makes the script flexible and reusable for different scenarios or clients.
- **How:** Use `$1`, `$2`, etc., or `getopts` to capture arguments and use them in your functions.

---

#### 5. Error Handling

- **What:** Add checks after each AWS command to see if it succeeded, and handle failures gracefully.
- **Why:** Prevents the script from failing silently or leaving resources in a bad state.
- **How:** Check the exit status (`$?`) after commands, print meaningful error messages, and exit or retry as needed.

---

#### **Summary Table**

| Requirement         | What to Do                                                                 |
|---------------------|----------------------------------------------------------------------------|
| Functions           | Write modular code for each AWS task                                       |
| Arrays              | Store and manage lists of created resources                                |
| Environment Vars    | Use for credentials and config (never hardcode sensitive info)             |
| Cmd Line Arguments  | Accept user input for dynamic script behavior                              |
| Error Handling      | Check for errors after commands and handle them properly                   |

---

#### Processes To Execute The Task

1. **Script Planning:** Outline which functions are needed.
2. **Set up environment variables:** Ensure AWS credentials and region are set.
3. **Accept arguments:** Decide which parameters should be customizable.
4. **Use arrays:** Store IDs/names of created resources.
5. **Add error handling:** After every AWS CLI command, check if it worked and handle errors.
6. **Test:** Try the script with different arguments and scenarios.

---

**Goal:**  
Automation of the creation and configuration of EC2 instances and S3 buckets on AWS, using best practices in shell scripting for modularity, security, flexibility, and reliability.
