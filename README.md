
# Terraform Docker MySQL Setup

This project contains a Terraform configuration to deploy a MySQL Docker container. The setup includes initializing a database, user, and populating a `users` table with initial data using an SQL script.

## Prerequisites

- Docker
- [Terraform](https://www.terraform.io/downloads)

### Install Terraform on Ubuntu

Run the following commands to install Terraform on Ubuntu:

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

## Installation and Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/sallemiahmed/terraform-docker-mysql.git
   cd terraform-docker-mysql
   ```

2. **Create the `init.sql` File**:

   Create a file named `init.sql` in the project root with the following contents:
   ```sql
   CREATE TABLE IF NOT EXISTS users (
     id INT AUTO_INCREMENT PRIMARY KEY,
     username VARCHAR(255) NOT NULL,
     email VARCHAR(255) NOT NULL
   );

   INSERT INTO users (username, email) VALUES
   ('user1', 'user1@example.com'),
   ('user2', 'user2@example.com');
   ```

3. **Initialize and Apply Terraform Configuration**:

   ```bash
   terraform init
   terraform apply
   ```

   When prompted, type `yes` to confirm the deployment.

## Testing

1. **Connect to the MySQL Container**:
   ```bash
   docker exec -it mysql-container mysql -u myuser -pmypassword mydatabase
   ```

   This command connects directly without prompting for the password (set in the Terraform configuration as `mypassword`).

2. **Verify Database**:
   Run the following commands inside the MySQL shell:

   ```sql
   USE mydatabase;
   SHOW TABLES;
   SELECT * FROM users;
   ```

   You should see the `users` table and the initial data.

3. **Exit MySQL**:
   ```sql
   exit;
   ```

## Clean Up

To remove all resources created by this Terraform setup, run:

```bash
terraform destroy
```

Confirm with `yes` when prompted.

## License

This project is licensed under the MIT License.
