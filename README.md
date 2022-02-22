# SagemakerTemplate

1. Install Requirements (will be most likely taken care of by the dev-container)
   1. Docker
   2. AWS Command-Line Interface (AWS CLI)
   3. VS Code
2. Login into AWS and ECR
   1. `lin` - anywhere from the terminal in the dev-container
   2. Open up the AWS SSO that you use to sign in >> AWS Account >> Command line or programmatic access >> Option 3
   3. The region should be set to `us-east-1`
   4. The format should be set to `json`
   5. Check instruction 2.2 for session token
3. Copy code
   1. `copy <absolute path to your code>`
4. Build
   1. `build`

## Push Instructions

1. Push your image to ECR
   1. `push`