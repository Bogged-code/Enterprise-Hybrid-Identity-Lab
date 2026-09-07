# Enterprise-Hybrid-Identity-Lab
Enterprise hybrid identity homelab featuring Active Directory DS on Windows Server 2025, GPOs, PowerShell bulk provisioning, and Google Cloud IAM RBAC mapping.

## Deployment & Configuration Gallery

### Phase 1: On-Premises Active Directory & Core Infrastructure

* **01_ad_ds_dns_installed.png**
  * **Title:** Active Directory Domain Services & DNS Role Verification
  * **Description:** Verified successful promotion of Windows Server 2025 (`WS-01`) to Primary Domain Controller for `lab.local`, displaying active AD DS and DNS roles in Server Manager.
  * **Image:**
    ![AD DS DNS Roles](screenshots/1_ad_ds_dns_installed.png)

* **02_ou_structure_created.png**
  * **Title:** Enterprise Organizational Unit (OU) Architecture
  * **Description:** Structured Active Directory hierarchy under `Bog_Employees`, provisioning departmental OUs (`IT`) to isolate identity objects for policy application.
  * **Image:**
    ![OU Architecture](screenshots/2_ou_structure_created.png)

* **03_user_and_group_provisioning.png**
  * **Title:** User Account & Security Group Creation
  * **Description:** Provisioned individual employee identity (`David Santos`) and security group (`bruh_IT_Department`) within Active Directory Users and Computers (`dsa.msc`).
  * **Image:**
    ![User and Group Provisioning](screenshots/3_user_and_group_provisioning.png)

* **04_user_account_attributes.png**
  * **Title:** User Principal Name (UPN) & Logon Configuration
  * **Description:** Configured domain account properties for `dsantos@lab.local`, establishing pre-Windows 2000 login attributes and password expiration policies.
  * **Image:**
    ![User Attributes](screenshots/4_user_account_attributes.png)

* **05_security_group_membership.png**
  * **Title:** Role-Based Access Control (RBAC) Group Nesting
  * **Description:** Populated security group `bruh_IT_Department` with user account `David Santos` to enable efficient permission auditing and file share authorization.
  * **Image:**
    ![Group Membership](screenshots/5_security_group_membership.png)

* **06_dns_resolution_verification.png**
  * **Title:** Client-Side DNS Resolution Audit (`nslookup`)
  * **Description:** Executed `nslookup` on client machine (`bog1`) to verify active forward resolution against Domain Controller IP (`10.0.2.10`).
  * **Image:**
    ![DNS Resolution](screenshots/6_dns_resolution_verification.png)

* **07_domain_join_confirmation.png**
  * **Title:** Endpoint Domain Authentication (`whoami`)
  * **Description:** Verified successful endpoint domain join to `lab.local` by authenticating domain user (`LAB\dsantos`) on client workstation.
  * **Image:**
    ![Domain Authentication](screenshots/7_domain_join_confirmation.png)

---

### Phase 2: Group Policy, Security & Network Storage

* **08_gpo_deployment.png**
  * **Title:** Group Policy Object (GPO) Linking & Scope
  * **Description:** Configured and linked custom GPO (`Restrict_ControlPanel`) to target OU (`Bog_Employees`) within Group Policy Management Console (`gpmc.msc`).
  * **Image:**
    ![GPO Deployment](screenshots/08_gpo_deployment.png)

* **09_gpo_enforcement_client.png**
  * **Title:** Client-Side Group Policy Enforcement
  * **Description:** Validated policy enforcement on endpoint workstation; Control Panel access blocked by administrative restriction upon execution attempt.
  * **Image:**
    ![GPO Enforcement](screenshots/09_gpo_enforcement_client.png)

* **10_smb_share_permissions.png**
  * **Title:** SMB Share & File Level Access Control
  * **Description:** Established network share (`david_files`) with Full Control share permissions restricted exclusively to departmental security group `bruh_IT_Department`.
  * **Image:**
    ![SMB Share Permissions](screenshots/10_smb_share_permissions.png)

* **11_ntfs_folder_permissions.png**
  * **Title:** NTFS Security Permissions & Access Control List (ACL)
  * **Description:** Configured Security tab properties on local directory `C:\david_files`, assigning Full Control NTFS permissions to domain group `bruh_IT_Department`.
  * **Image:**
    ![NTFS Permissions](screenshots/11_ntfs_folder_permissions.png)

* **12_smb_file_access_verification.png**
  * **Title:** Network File Share Creation & Read/Write Verification
  * **Description:** Verified client-side file creation and modification within network share `\\WS-01\david_files` while authenticated as domain user.
  * **Image:**
    ![SMB File Access Verification](screenshots/12_smb_file_access_verification.png)

* **13_gpo_drive_mapping_config.png**
  * **Title:** Group Policy Preferences Automated Drive Mapping
  * **Description:** Configured Drive Maps preference under User Configuration to automatically mount share `\\WS-01\david_files` as drive letter `A:`.
  * **Image:**
    ![GPO Drive Mapping](screenshots/13_gpo_drive_mapping_config.png)

* **14_item_level_targeting_group.png**
  * **Title:** Item-Level Targeting via Security Group Membership
  * **Description:** Applied Item-Level Targeting to the drive mapping policy, scoping drive mounting strictly to members of `LAB\bruh_IT_Department`.
  * **Image:**
    ![Item Level Targeting](screenshots/14_item_level_targeting_group.png)

* **15_gpupdate_mapped_drive_test.png**
  * **Title:** Client Policy Update & Mapped Drive Verification
  * **Description:** Executed `gpupdate /force` on client workstation to refresh policy and verify active access to share resources over the network.
  * **Image:**
    ![GPO Update Verification](screenshots/15_gpupdate_mapped_drive_test.png)

---

### Phase 3: Administrative Delegation & PowerShell Automation

* **16_delegation_of_control_wizard.png**
  * **Title:** Active Directory Administrative Control Delegation
  * **Description:** Completed Delegation of Control Wizard to grant user `dsantos` administrative permissions to reset passwords within organizational unit `Bog_Employees/IT`.
  * **Image:**
    ![Delegation of Control](screenshots/16_delegation_of_control_wizard.png)

* **17_powershell_csv_user_source.png**
  * **Title:** Bulk Identity Onboarding Data Source (`users.csv`)
  * **Description:** Prepared structured CSV import file containing `SamAccountName`, `GivenName`, `Surname`, `OU`, `Title`, and `Department` attributes for automated identity provisioning.
  * **Image:**
    ![CSV User Source](screenshots/17_powershell_csv_user_source.png)

* **18_powershell_bulk_user_script.png**
  * **Title:** Automated AD User Provisioning Script Execution
  * **Description:** Executed PowerShell automation script to parse `users.csv`, dynamically construct missing OUs, and create active domain accounts with default secure credentials.
  * **Image:**
    ![Bulk User Script Execution](screenshots/18_powershell_bulk_user_script.png)

* **19_aduc_cybersec_ou_users.png**
  * **Title:** Automated Provisioning Verification: CyberSec OU
  * **Description:** Confirmed successful bulk provisioning of user objects (`Jason Dayrit`, `Matthew Robert`) inside newly generated `CyberSec` Organizational Unit.
  * **Image:**
    ![CyberSec OU Verification](screenshots/19_aduc_cybersec_ou_users.png)

* **20_aduc_medical_ou_users.png**
  * **Title:** Automated Provisioning Verification: Medical OU
  * **Description:** Confirmed successful bulk provisioning of user object (`Jino Dena`) inside newly generated `Medical` Organizational Unit in Active Directory.
  * **Image:**
    ![Medical OU Verification](screenshots/20_aduc_medical_ou_users.png)

---

### Phase 4: Hybrid Cloud Identity Integration (GCP IAM)

* **21_hybrid_iam_role_mapping.png**
  * **Title:** Hybrid Cloud Identity Architecture & GCP IAM Integration
  * **Description:** Parallel view validating on-premises Active Directory `CyberSec` organizational unit alignment with Google Cloud Platform IAM custom roles (`AD-CyberSec-Head`) in `BogLab-Identity`.
  * **Image:**
    ![Hybrid Identity Architecture](screenshots/21_hybrid_iam_role_mapping.png)

* **22_gcp_iam_permissions_audit.png**
  * **Title:** Cloud IAM Principal Role & Access Audit
  * **Description:** Audited project-level access controls within GCP console, verifying custom role bindings (`AD-CyberSec-Head`, `Owner`, `Viewer`) assigned to the primary enterprise administrator.
  * **Image:**
    ![GCP IAM Audit](screenshots/22_gcp_iam_permissions_audit.png)
