[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

##### 設定ファイルからJIRA APIトークン、JIRA API実行ユーザ名、JIRA API URLを取得
$CONF_FILE_PATH="config/.env"
$PARAM=@{}
Get-Content $CONF_FILE_PATH | %{$PARAM += ConvertFrom-StringData $_}

$JIRA_API_TOKEN = $PARAM.JIRA_API_TOKEN.Replace('"','')
$JIRA_API_USER = $PARAM.JIRA_API_USER.Replace('"','')
$JIRA_API_URL = $PARAM.JIRA_API_URL.Replace('"','')
#####

##### CSVから作成するJIRAプロジェクト名、JIRAチケット名情報を取得
$csv = Import-Csv "create_jira_issues_name.csv" -Encoding UTF8

##### 作成するJIRAチケット本文用のJSONテンプレートファイルを指定
$template_json_file = "create_jira_issues_template.json"

##### 設定ファイルから取得したJIRA APIトークンをHTTPヘッダ情報にセット
$pair = "$($JIRA_API_USER):$($JIRA_API_TOKEN)"
$encoded_api_creds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))

# Create Auth Headers for Invoke-RestMethod
# in my case encoded Creds is loaded from Keepass with Module PoShKeePass and already Base64encoded
# Please dont use plain text credentials in scripts, due to security reasons. if you have a Read-Host method to get the pass thats ok.
$headers = @{
  Authorization = "Basic $encoded_api_creds"
  Accept = "application/json"
}
#####

# jsonフォルダ存在チェック
if ((Test-Path "json") -eq $false) {
  New-Item "json" -ItemType "directory"
}

##### CSVファイルから取得したJIRAプロジェクト名、JIRAチケット名情報に基づきJIRAチケットを作成する
$i = 0
foreach ($line in $csv){
  ${line}.JIRA_PROJECT_NAME
  ${line}.JIRA_ISSUE_NAME

  $output_json_file = "json/jira_api_test_post_issue_" + ${line}.PROJECT_NAME + "_" + $i + ".json"
  echo "$output_json_file"

  (Get-Content "$template_json_file") | Set-Content -Path "$output_json_file"
  (Get-Content "$output_json_file") | ForEach-Object {$_ -replace "JIRA_PROJECT_NAME", ${line}.JIRA_PROJECT_NAME} | Set-Content $output_json_file
  (Get-Content "$output_json_file") | ForEach-Object {$_ -replace "JIRA_ISSUE_NAME", ${line}.JIRA_ISSUE_NAME} | Set-Content $output_json_file

  $payload = Get-Content "$output_json_file" -RAW
  $json_payload = $payload
  echo ${json_payload}
  Invoke-RestMethod -Method POST -Uri $JIRA_API_URL -ContentType 'application/json' -Headers $headers -Body $json_payload

  echo $i
  $i++;
}

# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Invoke-WebRequest https://example.com/
