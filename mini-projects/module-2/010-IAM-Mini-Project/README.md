# IAM Mini Project

## IAM User

An **IAM User** in AWS (Identity and Access Management) is an entity that you create in your AWS account to represent a person or application that interacts with AWS resources. Each IAM user has its own credentials and permissions.

### Key Points

- **Unique Credentials:** Each user has a unique name and can have their own password for AWS Management Console access and/or access keys for programmatic access.
- **Permissions:** Permissions are assigned to users through IAM policies, which define what actions the user can perform on which AWS resources.
- **Best Practice:** Avoid using the root account for everyday tasks. Instead, create individual IAM users for each person or application that needs access.

### How to Create an IAM User

1. Sign in to the AWS Management Console as an administrator.
2. Navigate to **IAM > Users**.
3. Click **Add user**.
4. Enter a user name and select the type of access (console, programmatic, or both).
5. Assign permissions directly or add the user to one or more groups.
6. Review and create the user. Download or securely store the credentials.

### Example Use Cases

- Assigning unique credentials to each team member.
- Creating users for applications or services that need to interact with AWS.
- Managing permissions and access control at a granular level.

IAM users are fundamental to securely managing access to your AWS resources.

## IAM Policy

An **IAM Policy** is a JSON document in AWS that defines permissions for actions on AWS resources. Policies are attached to IAM users, groups, or roles to specify what actions they are allowed or denied to perform.

### Policy Key Points

- **Document Structure:** Policies are written in JSON and consist of one or more statements, each specifying an effect (Allow or Deny), actions, and resources.
- **Granular Control:** Policies allow you to control access at a very granular level, specifying exactly which AWS services and resources can be accessed and what actions can be performed.
- **Attach to Identities:** Policies can be attached directly to users, groups, or roles.

### Example IAM Policy

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket",
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  ]
}
```

### Types of Policies

- **Managed Policies:** Predefined by AWS or created by you, and can be attached to multiple identities.
- **Inline Policies:** Embedded directly into a single user, group, or role.

### Best Practices

- Grant least privilege: Only allow the permissions necessary for the task.
- Use AWS managed policies for common use cases.
- Regularly review and update policies to maintain security.

IAM policies are essential for defining and enforcing access control in your AWS environment.

## IAM Role

An **IAM Role** in AWS is an identity with specific permissions that can be assumed by users, AWS services, or applications. Unlike an IAM user, a role does not have long-term credentials (like a password or access keys) associated with it. Instead, roles are intended to be assumed temporarily and provide secure access to AWS resources.

### Role Key Points

- **Temporary Credentials:** When a role is assumed, AWS provides temporary security credentials for the duration of the session.
- **Assumable by Entities:** Roles can be assumed by IAM users, AWS services (like EC2, Lambda), or external users (via identity federation).
- **Use Cases:** Commonly used for granting permissions to AWS services, enabling cross-account access, or allowing federated users to access AWS resources.

### Example of Role Use Cases

- **EC2 Instance Role:** Assign a role to an EC2 instance to allow it to access S3 buckets or other AWS services without embedding credentials in the application.
- **Cross-Account Access:** Allow users in one AWS account to access resources in another account by assuming a role.
- **Federated Access:** Allow users authenticated outside AWS (e.g., via Google, Active Directory) to assume a role and access AWS resources.

### Example Trust Policy

A trust policy defines who can assume the role. For example, to allow EC2 instances to assume a role:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### Role Best Practices

- Grant only the permissions needed for the task (principle of least privilege).
- Regularly review and update role permissions and trust policies.
- Use roles instead of sharing long-term credentials for applications and services.

IAM roles are a powerful way to securely delegate access and permissions within AWS.

## IAM Group

An **IAM Group** in AWS is a collection of IAM users. Groups let you specify permissions for multiple users at once, making it easier to manage permissions for users who perform similar functions.

### Group Key Points

- **Permission Management:** Attach policies to a group, and all users in that group automatically receive the permissions specified by those policies.
- **No Credentials:** Groups do not have their own credentials; only users have credentials.
- **Simplifies Administration:** Instead of assigning permissions to each user individually, you can assign them to a group and add users to that group.

### Example of Group Use Cases

- Creating a group called `Developers` and attaching policies that allow access to development resources.
- Creating an `Admins` group with administrative permissions for users who manage AWS resources.
- Managing permissions for teams or departments by grouping users accordingly.

### How to Create and Use an IAM Group

1. Sign in to the AWS Management Console as an administrator.
2. Navigate to **IAM > Groups**.
3. Click **Create New Group** and provide a group name.
4. Attach one or more policies to the group.
5. Add users to the group.

### Group Best Practices

- Use groups to manage permissions for users with similar job functions.
- Regularly review group memberships and attached policies.
- Remove users from groups if their job responsibilities change.

IAM groups help you efficiently manage user permissions and maintain security best practices in your AWS environment.

## Handson Practices

### Creating Policy with all ec2 actions for user Eric

![aws_console](images/console1.png)
![aws_console](images/console2.png)
![aws_console](images/console3.png)
![aws_console](images/console4.png)
![aws_console](images/console5.png)
![aws_console](images/console6.png)

### Creating User Eric And Assigning Policy `Policy_for_eric` To Him

![aws_console](images/console7.png)
![aws_console](images/console8.png)
![aws_console](images/console9.png)
![aws_console](images/console10.png)

### Creating Group `Development-team`

![aws_console](images/console11.png)
![aws_console](images/console12.png)

### Creating Users `Ade` & `Jack` And Adding Then To `Development-team` Group

![aws_console](images/console13.png)
![aws_console](images/console14.png)
![aws_console](images/console15.png)
![aws_console](images/console16.png)
![aws_console](images/console17.png)
![aws_console](images/console18.png)
![aws_console](images/console19.png)
![aws_console](images/console20.png)

### Creating Policy `Development-team-policy` And Attaching all EC2 and S3 Actions To It

![aws_console](images/console21.png)
![aws_console](images/console22.png)
![aws_console](images/console23.png)
![aws_console](images/console24.png)
![aws_console](images/console25.png)
![aws_console](images/console26.png)
![aws_console](images/console27.png)

### Assigning Policy `Development-team-policy` To User Group `Development-team`

By virtue of this, all users in the development team group automatically has permissions to perform all ec2 and s3 actions.
![aws_console](images/console28.png)
![aws_console](images/console29.png)
![aws_console](images/console30.png)
![aws_console](images/console31.png)
