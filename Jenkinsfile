@Library('pipeline-jenkins@hotfix/terraform_fmt') _

fxTerraformWithUsernamePassword(
  testEnvironmentCredentialId: 'itoa-application-awscollectors-awscred',
  publishEnvironmentCredentialId: 'itoa-application-awscollectors-awscred',
  providerUsernameVariableName: 'access_key',
  providerPasswordVariableName: 'secret_key',
  initSSHCredentialId: 'gitea-fx_administrator-key',
  commonOptions: [
    dockerImage: 'fxinnovation/terraform:2.5.0'
  ] 
)
