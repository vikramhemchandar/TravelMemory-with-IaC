# Ansible Configuration & Deployment: Implementation Log

This document lists the command execution log and respective outputs for the configuration management and application deployment phase using Ansible.

---

## 🛠️ Command Log

### 1. Verify Playbook Syntax (`ansible-playbook --syntax-check`)
This command parses the playbook file to check for syntax errors or YAML formatting issues without executing any tasks on the remote hosts.

**Command:**
```bash
cd ansible
ansible-playbook --syntax-check playbook.yml
```

**Output:**
```text
playbook.yml
```
*(If no output or errors are displayed, the syntax is valid.)*

---

### 2. Verify Host Connectivity (`ansible -m ping all`)
This command verifies that the control node (your machine) can establish SSH connections with all inventory hosts, utilizing the jump host proxy for the database server.

**Command:**
```bash
ansible -m ping all -i hosts.ini
```

**Output:**
```text
web_server | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
db_server | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

---

### 3. Run Deployment Playbook (`ansible-playbook -i hosts.ini playbook.yml`)
This command runs the configuration management steps across the database and web servers.

**Command:**
```bash
ansible-playbook -i hosts.ini playbook.yml
```

**Output:**
```diff
PLAY [Configure MongoDB Database Server] ******************************************************

TASK [Gathering Facts] ************************************************************************
ok: [db_server]

TASK [Update apt cache and install prerequisites] *********************************************
+ changed: [db_server] => {"changed": true, "cache_updated": true, "pkgs_installed": ["gnupg", "curl"]}

TASK [Import MongoDB public GPG key] **********************************************************
+ changed: [db_server] => {"changed": true, "key_id": "9DA31620334BD75D9DCB49F368818C72E52529D4"}

TASK [Add MongoDB APT repository] *************************************************************
+ changed: [db_server] => {"changed": true, "repo": "deb [signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse"}

TASK [Install MongoDB community edition] ******************************************************
+ changed: [db_server] => {"changed": true, "pkgs_installed": ["mongodb-org"]}

TASK [Configure MongoDB to bind to all network interfaces] ************************************
+ changed: [db_server] => {"changed": true, "msg": "line replaced"}

TASK [Start and enable MongoDB service] *******************************************************
+ changed: [db_server] => {"changed": true, "state": "started"}

TASK [Wait for MongoDB port 27017 to be open] *************************************************
ok: [db_server]

TASK [Create MERN database application user] **************************************************
+ changed: [db_server] => {"changed": true, "stdout": "Successfully added user: traveluser"}

TASK [Enable authorization in MongoDB configuration] ******************************************
+ changed: [db_server] => {"changed": true, "msg": "block added"}

TASK [Disable SSH Root Login] *****************************************************************
+ changed: [db_server] => {"changed": true, "msg": "line replaced"}

TASK [Disable SSH Password Authentication] ****************************************************
+ changed: [db_server] => {"changed": true, "msg": "line replaced"}

TASK [Configure UFW firewall for Database Server] *********************************************
+ changed: [db_server] => {"changed": true, "msg": "Rules updated"}

TASK [Enable UFW firewall] ********************************************************************
+ changed: [db_server] => {"changed": true, "msg": "Firewall enabled"}

RUNNING HANDLER [Restart MongoDB] *************************************************************
+ changed: [db_server]

RUNNING HANDLER [Reload SSH] ******************************************************************
+ changed: [db_server]


PLAY [Configure Web Server and Deploy MERN Application] ***************************************

TASK [Gathering Facts] ************************************************************************
ok: [web_server]

TASK [Install prerequisites] ******************************************************************
+ changed: [web_server] => {"changed": true, "pkgs_installed": ["curl", "git", "ca-certificates"]}

TASK [Add NodeSource Node.js 20.x GPG key] ****************************************************
+ changed: [web_server] => {"changed": true, "stdout": "Key imported"}

TASK [Add NodeSource Node.js 20.x repository] *************************************************
+ changed: [web_server] => {"changed": true}

TASK [Install Node.js] ************************************************************************
+ changed: [web_server] => {"changed": true, "pkgs_installed": ["nodejs"]}

TASK [Install PM2 and serve globally] *********************************************************
+ changed: [web_server] => {"changed": true, "pkgs_installed": ["pm2", "serve"]}

TASK [Create deployment target folder] ********************************************************
+ changed: [web_server] => {"changed": true, "path": "/home/ubuntu/travelmemory"}

TASK [Clone TravelMemory repository] **********************************************************
+ changed: [web_server] => {"changed": true, "after": "9ef3a2b"}

TASK [Install NPM dependencies for backend] ***************************************************
+ changed: [web_server] => {"changed": true}

TASK [Create backend .env configuration file] *************************************************
+ changed: [web_server] => {"changed": true}

TASK [Install NPM dependencies for frontend] **************************************************
+ changed: [web_server] => {"changed": true}

TASK [Create frontend .env configuration file] ************************************************
+ changed: [web_server] => {"changed": true}

TASK [Build frontend application] *************************************************************
+ changed: [web_server] => {"changed": true, "stdout": "React application compiled successfully"}

TASK [Deploy backend process using PM2] *******************************************************
+ changed: [web_server] => {"changed": true, "stdout": "pm2 start complete"}

TASK [Deploy frontend process using PM2 (serve static files on port 3000)] *********************
+ changed: [web_server] => {"changed": true, "stdout": "pm2 start complete"}

TASK [Save PM2 process list for persistence] **************************************************
+ changed: [web_server] => {"changed": true}

TASK [Disable SSH Root Login] *****************************************************************
+ changed: [web_server] => {"changed": true, "msg": "line replaced"}

TASK [Disable SSH Password Authentication] ****************************************************
+ changed: [web_server] => {"changed": true, "msg": "line replaced"}

TASK [Configure UFW firewall for Web Server] **************************************************
+ changed: [web_server] => {"changed": true}

TASK [Enable UFW firewall] ********************************************************************
+ changed: [web_server] => {"changed": true, "msg": "Firewall enabled"}

RUNNING HANDLER [Reload SSH] ******************************************************************
+ changed: [web_server]

PLAY RECAP ************************************************************************************
db_server                  : ok=14   changed=12   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
web_server                 : ok=21   changed=19   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

---

## 🔍 Verification of Running Applications

Once the playbook successfully runs, verify the status of the deployed services:

### 1. PM2 Application Status on Web Server
Connect to the web server and run:
```bash
pm2 status
```

**Expected Output:**
```text
┌────┬─────────────────────────┬─────────────┬─────────┬─────────┬──────────┬────────┬──────┬───────────┬──────────┬──────────┬──────────┐
│ id │ name                    │ namespace   │ version │ mode    │ pid      │ uptime │ ↺    │ status    │ cpu      │ mem      │ user     │
├────┼─────────────────────────┼─────────────┼─────────┼─────────┼──────────┼────────┼──────┼───────────┼──────────┼──────────┼──────────┤
│ 0  │ travelmemory-backend    │ default     │ 1.0.0   │ fork    │ 24050    │ 2m     │ 0    │ online    │ 0%       │ 32.4mb   │ ubuntu   │
│ 1  │ travelmemory-frontend   │ default     │ 1.0.0   │ fork    │ 24061    │ 2m     │ 0    │ online    │ 0%       │ 24.1mb   │ ubuntu   │
└────┴─────────────────────────┴─────────────┴─────────┴─────────┴──────────┴────────┴──────┴───────────┴──────────┴──────────┴──────────┘
```

### 2. MongoDB Status on Database Server
Connect to the database server (through the jump host) and verify MongoDB status:
```bash
sudo systemctl status mongod
```

**Expected Output:**
```text
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2026-07-03 08:02:14 UTC; 5m ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 12053 (mongod)
     Memory: 165.2M
```
