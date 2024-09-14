# overview
this is a JIRA issues creation script created with PowerShell. create a JIRA issues using the JIRA REST API.

# setting procedure

```
% git clone git@github.com:na0AaooQ/example_powershell_create_jira_issues.git

% cd example_powershell_create_jira_issues

% cp -p config/.env.example config/.env

% vi config/.env
JIRA_API_TOKEN="JIRA REST APIトークンを記載する"
JIRA_API_USER="JIRA APIユーザ名のメールアドレスを記載する(例 xxxxx@example.com)"
JIRA_API_URL="https://xxxxxxx.atlassian.net/rest/api/2/issue"

% pwsh create_jira_issues.ps1
```

# demo image

## sccreen before execution for jira.

<img width="1491" alt="スクリーンショット 2024-09-14 22 05 54" src="https://github.com/user-attachments/assets/4626daf6-de42-492a-b12d-39eb53615e03">

settings 

## setting procedure example.

<img width="1377" alt="スクリーンショット 2024-09-14 22 06 32" src="https://github.com/user-attachments/assets/bbfed99f-5df3-4cdd-af76-608ddbdd831c">

## exec PowerShell for create jira issues.

<img width="1378" alt="スクリーンショット 2024-09-14 22 20 38" src="https://github.com/user-attachments/assets/554edf7e-9c48-4e59-b131-fe87b9d62c5b">

<img width="1379" alt="スクリーンショット 2024-09-14 22 13 57" src="https://github.com/user-attachments/assets/5887e80c-2869-4a74-9195-fe3379cf7587">

## sccreen after execution for jira.

<img width="1478" alt="スクリーンショット 2024-09-14 22 07 26" src="https://github.com/user-attachments/assets/f5a2ce46-f1e2-49f6-a110-6cb7cbae6989">

<img width="1473" alt="スクリーンショット 2024-09-14 22 07 34" src="https://github.com/user-attachments/assets/793237fe-8a81-4da3-9e88-136ea2216704">
