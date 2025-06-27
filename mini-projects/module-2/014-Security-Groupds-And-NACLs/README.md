# Security Groups And NACLs

## Security Group

A **Security Group** in AWS acts as a virtual firewall for your EC2 instances and other resources within your VPC. It controls inbound and outbound traffic at the instance level.

### Key Points

- **Stateful:** If you allow an incoming request from an IP, the response is automatically allowed, regardless of outbound rules.
- **Rules-Based:** You define rules based on protocols (TCP, UDP, ICMP), port ranges, and source/destination IP addresses or CIDR blocks.
- **Default Deny:** By default, all inbound traffic is denied and all outbound traffic is allowed. You must explicitly add rules to allow specific inbound traffic.
- **Applies to Instances:** You can associate one or more security groups with each EC2 instance.

### Example: Allow SSH and HTTP Access

```bash
# Allow SSH (port 22) from a specific IP
aws ec2 authorize-security-group-ingress --group-id sg-12345678 --protocol tcp --port 22 --cidr 203.0.113.0/24

# Allow HTTP (port 80) from anywhere
aws ec2 authorize-security-group-ingress --group-id sg-12345678 --protocol tcp --port 80 --cidr 0.0.0.0/0
```

### Best Practices

- Grant only the minimum permissions required (principle of least privilege).
- Regularly review and update security group rules.
- Remove unused security groups and rules to reduce your attack surface.
- Use security groups in combination with network ACLs for layered security.

Security groups are essential for controlling access to your AWS resources and protecting your cloud

## NACL (Network Access Control List)

A **Network Access Control List (NACL)** is an optional layer of security for your VPC that acts as a stateless firewall for controlling traffic in and out of one or more subnets.

### NACL Key Points

- **Stateless:** Unlike security groups, NACLs are stateless. This means that return traffic must be explicitly allowed by rules.
- **Subnet Level:** NACLs operate at the subnet level, providing a way to control traffic to and from all resources in a subnet.
- **Rules:** You define numbered rules for both inbound and outbound traffic. Rules are evaluated in order, starting from the lowest number.
- **Default NACL:** Every VPC automatically comes with a default NACL, which allows all inbound and outbound traffic.
- **Custom NACLs:** You can create custom NACLs and associate them with one or more subnets.

### Example: Allow HTTP and Deny All Else

```bash
# Allow inbound HTTP (port 80) from anywhere
Rule #100: Type=HTTP, Protocol=TCP, Port Range=80, Source=0.0.0.0/0, Allow

# Deny all other inbound traffic
Rule #* (asterisk): Deny
```

### NACL Best Practices

- Use NACLs to provide an additional layer of security at the subnet level.
- Place more specific allow rules before broader deny rules.
- Regularly review and update NACL rules to match your security requirements.
- Remember that both inbound and outbound rules must allow traffic for it to flow.

NACLs are useful for securing your VPC at the subnet level, especially in environments with strict compliance

## Difference Between Security Groups and NACLs

| Feature                | Security Group                                 | Network ACL (NACL)                                  |
|------------------------|------------------------------------------------|-----------------------------------------------------|
| Level                  | Instance level (attached to EC2 instances)     | Subnet level (applies to all resources in a subnet) |
| Stateful/Stateless     | Stateful (automatically allows return traffic) | Stateless (return traffic must be explicitly allowed)|
| Rules                  | Only allow rules (no deny rules)               | Both allow and deny rules                           |
| Evaluation Order       | All rules are evaluated                        | Rules are evaluated in order, from lowest to highest|
| Default Behavior       | Deny all inbound, allow all outbound           | Allow all inbound and outbound (default NACL)       |
| Association            | Can be associated with multiple instances      | Can be associated with multiple subnets             |
| Use Case               | Fine-grained control for instance access       | Broad control for subnet-level access               |

### Summary

- **Security Groups** are best for controlling access to individual instances.
- **NACLs** are best for controlling traffic at the subnet level and for adding an extra layer of security.
- In most architectures, both are used together for

## HandOn Experience

First of all I will try to create an ec2 instance in the VPC from the previous project that can be accessed here [AWS VPC project](https://github.com/abuhanaan/darey.io/blob/main/mini-projects/module-2/013-AWS-VPC/README.md)

### Creating An EC2 instance inside the public subnet of the previously created VPC

![console](images/console1.png)
![console](images/console2.png)
![console](images/console3.png)
![console](images/console4.png)
![console](images/console5.png)
![console](images/console7.png)

- The image below shows the current security group setup on the instance. In the inbound rules, only IPv4 SSH traffic on port 22 is permitted to access the instance.
![console](images/console8.png)

- For the outbound rule, all IPv4 traffic with any protocol on any port number is allowed, i.e this instance has unrestricted access to anywhere on the internet.
![console](images/console9.png)

### Testing the accessibility of the site that is being served on the instance

Using the public IP address of the instance, the browser image below shows the instance is unreachable
![browser](images/browser1.png)
This is due to the fact that the current setuo of the security doesn't have HTTP protocol so whenever the outside world is trying to go inside the ec2 instance and trying to get data, security group is restricting their access

#### Solution

To resolve this issue, one can created a new security group that allows HTTP(port 80) traffic to come in:

- Click **Security Groups** on the left side bar and click on **Create security group** on the top right hand side of the page
![console](images/console10.png)
- Specify a name and description for the new security group and ensure to select the specific VPC that was created in the previous project.
- click on add rule.
- Select HTTP as the type
- Use `0.0.0.0/0` as the CIDR block, this allows every CIDR block.
- Leave the outboud rule as it is.
![console](images/console11.png)
![console](images/console12.png)
- Click on **Create Security Group**
![console](images/console13.png)
The next step is to attach this security group to the ec2 instance

### Attaching the newly created security group to instance

- Select **instance** on the left side bar and click on **Actions** drop down button on the top right hand side of the page, the select **Security**, then click on **Change security groups**
![console](images/console14.png)
- Select the security that was created
![console](images/console15.png)
- Click on **Add security Group**, then click on **save**. The **Launch wizard** security group was attached to the instance at the point of creation. It can also be edited.
![console](images/console16.png)
![console](images/console17.png)

Now if we go to the browser and check the accessibility of the instance using the public address
![browser](images/browser2.png)
The above image shows the instance is now accessible from the outside world using HTTP protocol.

### Reviewing How Inbound And Outbound Rules Are Configured

- The setup below allows HTTP and SSH request to access the instance
![console](images/console18.png)
- The outbound rule permits all traffic to exit the instance
![console](images/console19.png)
- Through this rule we're able to access the website
![browser](images/browser2.png)
- Now go to outbound rules, click on **edit outbound rules**, click on **Delete** and click on **save**
![console](images/console20.png)

After making this changes lets investigate whether or not the site is still accessible.
![browser](images/browser2.png)

- NOTE: Even though we have removed the outbound rule, the site is still accessible. Ideally the site is not supposed to be accessible because of the outbound rule removal. The reason the site is still accessible is because: </br>
Security groups are stateful, that is they automatically allow return traffic initiated by the instance to which they are attached. So, even after removing the outbound rule, the security group allow the return traffic necessary for dispalying the content of the site. </br>

Exploring the scenario further, If both the inbound and outbound rules were to be deleted, essentially we're closing all traffic to and fro the instance. So if we attempt to access the instance from the browser or any other client, it will fail because there are no rules permitting traffic to reach the instance. Similarly the instance wont be able to communicate with any external services or website because outbound traffic is also blocked

- Now lets delete the inbound rule the same way we have deleted the outbound rule.
![console](images/console21.png)
![console](images/console22.png)
![console](images/console23.png)
![console](images/console24.png)

- The images below show there are no outbound and inbound rules anymore
![console](images/console24.png)
![console](images/console25.png)

- Deleting the inboud and outbound rules means the instance is essentially isolated from both incoming and outgoing traffics. Lets try and access the site again an see what happens
![browser](images/browser1.png)
The image above shows the site is no more availabe because the instance is unreachable.

- Now lets add a rule that allows HTTP traffic in the outbound rules. </br>
Click on **edit outbound** rule in the Outbound tab, click on **add rule**, select type, choose destination choose CIDR then click on **save rules**
![console](images/console26.png)
![console](images/console27.png)
![console](images/console28.png)

Now let's see if we can access the website
![browser](images/browser1.png)
The above shows we can not access the website. But if we try to access the outside world by running `curl http://www.amazon.com` right from the instance.</br>
The instance was able to fetch data from external resources i.e it can communicate any HTTP-based service on the internet. This adjustments ensures that while incoming connections to the instance may still be restricted the instance itself can actively communicate over HTTP to external services on the internet.

___

### Setting up NACL

- Search **VPC** on the serach bar then click on VPC
- Click on **Network ACLs** on the side bar, click on **Create Network ACL** on the top right hand side of the page.
- Select a name for the NACL
- Select the VPC that was created in the previous project, then click on **create Network ACL**
![console](images/console29.png)
![console](images/console30.png)

- Select the just created NACL, select the **inbound rules** tab </br>
Notice that the NACL is currrently denying traffice from all ports
![console](images/console31.png)
- Similarly, if you check the **Outbound rules** you would notice that the NACL is also denying all outboumd traffics from all ports.</br>

To make changes:

- Select the NACL, go to **inbound rules** tab and click on **edit inbound rules**
- Click on **Add new rule**, now choose the rule number, select the type, source and determine whether to allow or deny the traffic, then click on save changes.
![console](images/console32.png)
![console](images/console33.png)
![console](images/console34.png)
![console](images/console35.png)

___
Currently this NACL is not associated with any of the subnets in the VPC, to associate it:

- select the NACL
- clicl on **Actions** on the top right hand conner of the page and select **Edit subnet associations**
![console](images/console36.png)
- Select the public subnet as the ec2 instance resides in the public subnet.</br>
Once selected, it should be vissible under selected subnets as it is shown in the image below
![console](images/console37.png)
- Click on *Save changes** and this associates the public subnet with the NACL
![console](images/console38.png)
![console](images/console39.png)
![console](images/console40.png)
![console](images/console41.png)
![console](images/console42.png)

Now lets try to access the website again
![browser](images/browser5.png)
The above image shows the site is not accessible. Although all traffic in the inbound rule of the NACl has been permitted but the site is still not accessible.</br>
The reason the site isnt accessible despite the NACL inbound permissions is because NACLs are stateless. They dont automatically allow return traffic. As a result, it is essential to specifically configure rules for both inbound and outbound traffics. </br>
Even though the inbound rules allow traffic into the subnet, the outbound rules is are still denying all traffics
![diagram](images/diagram1.png)

___

To make the site accessible, there is need to allow outbound traffic on the NACL

- Selct the NACL, click on the **Outbound rules** tab and click on **edit outbound rules**
- Click on **Add new rule**, now choose the rule number, select the type, source and determine whether to allow or deny the traffic, then click on save changes.
![console](images/console43.png)
![console](images/console44.png)
![console](images/console45.png)

Let us now try to access the website again
![browser](images/browser6.png)
Voilla!!! the site is now accessible.

___

Now let's see one more interesting scenario

In this Scenario:

- Security Group: Allows inbound traffic for HTTP and SSH protocols and permit all inbound traffic
- Network ACL: Denies all inbound traffic. Let's observe the outcome of this configuration

### Security Group Scenario

- If we configure security group to allow HTTP and SSH traffic in the inbound rules. If we then allow all outbound traffic, then go ahead to remove/deny all traffic(inbound and outbound) in the NACL.
- If we then try to access the site, the site will be inaccessible
![browser](images/browser1.png)
The reason the site is inaccessible is because the NACL has denied inbound traffic. This prevents traffic from reaching the security group.

___

### Lets look at some other scenarios and their outcomes

- NACL allows all inbound and outbound traffic while Sucurity group denies all inbound and outboud traffic.</br>
**Outcome**: Website access will be blocked because the security group denies all traffic overriding the NACL's allowance.
- NACL denies all inbound and outbound traffic while Sucurity group allows all inbound and outboud traffic.</br>
**Outcome**: Website access will be blocked because the NACL denies all traffic regardless of the security group's allowance
- NACL allows HTTP inbound traffic, outbound traffic is denied while Security group allows inbound traffic and denies outbpund traffic.</br>
**Outcome**: Website access will be blocked because the security group allows HTTP inbound traffic regardless of the NACL's allowance. However if the website requires outbound traffic to function properly, it wont work due to the security group's denial of outbound traffic.
- NACL allows all inbound and outbound traffic while Security Group allows HTTP inbound traffic and denies outbound traffic.</br>
**Outcome**: Website access will be allowed because the security group allows HTTP inbound traffic regardless of the NACL's allowance. However if the website requires outbound traffic to function properly, it wont work due to security group's deniall of outbound traffic
- NACL allows all inbound and outbound traffic while Sucurity group allows all inbound and outboud traffic.</br>
**Outcome**: Website access will be allowed because both NACL and Security Group allow all traffic
- NACL denies all inbound and outbound traffic while Sucurity group allows HTTP inbound traffic and denies outboud traffic.</br>
**Outcome**: Website access will be blocked because NACL denies all traffic, regardless of the security group's allowance.
